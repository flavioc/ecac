import weka.classifiers.trees.J48;
import weka.classifiers.Evaluation;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.experiment.InstanceQuery;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.ReplaceMissingValues;
import weka.filters.unsupervised.attribute.MathExpression;
import weka.filters.unsupervised.attribute.NumericToNominal;

public class C45 {
	
	private static final int AGE_ATTRIBUTE = 0;
	private static final int WORKCLASS_ATTRIBUTE = 1;
	private static final int EDUCATION_ATTRIBUTE = 2;
	private static final int MARITAL_STATUS_ATTRIBUTE = 3;
	private static final int OCCUPATION_ATTRIBUTE = 4;
	private static final int RELATIONSHIP_ATTRIBUTE = 5;
	private static final int RACE_ATTRIBUTE = 6;
	private static final int SEX_ATTRIBUTE = 7;
	private static final int CAPITAL_GAIN_ATTRIBUTE = 8;
	private static final int CAPITAL_LOSS_ATTRIBUTE = 9;
	private static final int HOURS_PER_WEEK_ATTRIBUTE = 10;
	private static final int NATIVE_COUNTRY_ATTRIBUTE = 11;
	
	private static String MAIN_SQL = "select age, workclass, education, " +
	"marital_status, occupation, relationship, " +
	"race, sex, capital_gain, capital_loss, " +
	"hours_per_week, native_country, plus_50 from ";
	private static String TRAIN_QUERY =  MAIN_SQL + "adult";
	private static String TEST_QUERY = MAIN_SQL + "adult_test";
	
	private static Instances numericToNominal(Instances data, int []attributes) throws Exception {
		NumericToNominal filter = new NumericToNominal();
		filter.setAttributeIndicesArray(attributes);
		filter.setInputFormat(data);
		return Filter.useFilter(data, filter);
	}
	
	private static void changeUnknown(Instances data, int attr)
	{
		for(int i = 0; i < data.numInstances(); ++i) {
			Instance inst = data.instance(i);
			if(inst.stringValue(attr).equals("unknown")) {
				inst.setMissing(attr);
			}
		}
	}
	
	private static Instances discretizeCapital(Instances data, int attr) throws Exception
	{
		// discretize capital gain/loss
		// 0 - none
		// 0 - 100 : very low
		// 100 - 1000 : low
		// 1000 - 5000 : medium
		// 5000 - 10000 : high
		// > 10000 : very high
		MathExpression g = new MathExpression();
		g.setOptions(weka.core.Utils.splitOptions("-V -R " + (attr + 1)));
		g.setExpression("ifelse(A=0, 1, ifelse(A<100, 2, ifelse(A<1000, 3, ifelse(A<5000, 4, ifelse(A<10000, 5, 6)))))");
		g.setInputFormat(data);
		return Filter.useFilter(data, g);
	}
	
	private static void renameCapital(Instances data, int attr)
	{
		Attribute g_attr = data.attribute(attr);
		data.renameAttributeValue(g_attr, "1", "none");
		try {
			data.renameAttributeValue(g_attr, "2", "very_low");
		} catch(IllegalArgumentException e) {
			
		}
		data.renameAttributeValue(g_attr, "3", "low");
		data.renameAttributeValue(g_attr, "4", "medium");
		try {
			data.renameAttributeValue(g_attr, "5", "high");
		} catch(IllegalArgumentException e) {
			
		}
		try {
			data.renameAttributeValue(g_attr, "6", "very_high");
		} catch(IllegalArgumentException e) {
			
		}
	}
	
	private static Instances prepareData(String sql, String user, String password) throws Exception {
		InstanceQuery query = new InstanceQuery();
		query.setUsername(user);
		query.setPassword(password);
		
		query.setQuery(sql);
		
		Instances data = query.retrieveInstances();
		
		// discretize age
		MathExpression age = new MathExpression();
		
		age.setOptions(weka.core.Utils.splitOptions("-V -R " + (AGE_ATTRIBUTE + 1)));
		age.setExpression("ifelse(A<25, 1, ifelse(A<45, 2, ifelse(A<65, 3, 4)))");
		age.setInputFormat(data);
		data = Filter.useFilter(data, age);
		
		data = discretizeCapital(data, CAPITAL_GAIN_ATTRIBUTE);
		data = discretizeCapital(data, CAPITAL_LOSS_ATTRIBUTE);
		
		// discretize hours per week
		MathExpression hpk = new MathExpression();
		hpk.setOptions(weka.core.Utils.splitOptions("-V -R " + (HOURS_PER_WEEK_ATTRIBUTE + 1)));
		hpk.setExpression("ifelse(A<25, 1, ifelse(A<40, 2, ifelse(A<60, 3, 4)))");
		hpk.setInputFormat(data);
		data = Filter.useFilter(data, hpk);
		
		// change some attributes from numeric to nominal
		int [] attributesNominal = new int[5];
		attributesNominal[0] = AGE_ATTRIBUTE;
		attributesNominal[1] = data.numAttributes()-1;
		attributesNominal[2] = HOURS_PER_WEEK_ATTRIBUTE;
		attributesNominal[3] = CAPITAL_GAIN_ATTRIBUTE;
		attributesNominal[4] = CAPITAL_LOSS_ATTRIBUTE;
		data = numericToNominal(data, attributesNominal);
		
		// rename nominal attributes...
		
		Attribute plus_50 = data.attribute(data.numAttributes()-1);
		data.renameAttributeValue(plus_50, "0", "<50K");
		data.renameAttributeValue(plus_50, "1", ">50K");
		
		Attribute age_attr = data.attribute(AGE_ATTRIBUTE);
		data.renameAttributeValue(age_attr, "1", "young");
		data.renameAttributeValue(age_attr, "2", "middle_aged");
		data.renameAttributeValue(age_attr, "3", "senior");
		data.renameAttributeValue(age_attr, "4", "old");
		
		Attribute hpk_attr = data.attribute(HOURS_PER_WEEK_ATTRIBUTE);
		data.renameAttributeValue(hpk_attr, "1", "part_time");
		data.renameAttributeValue(hpk_attr, "2", "full_time");
		data.renameAttributeValue(hpk_attr, "3", "over_time");
		data.renameAttributeValue(hpk_attr, "4", "workaholic");
		
		renameCapital(data, CAPITAL_GAIN_ATTRIBUTE);
		renameCapital(data, CAPITAL_LOSS_ATTRIBUTE);
		
		// unknowns
		changeUnknown(data, WORKCLASS_ATTRIBUTE);
		changeUnknown(data, EDUCATION_ATTRIBUTE);
		changeUnknown(data, MARITAL_STATUS_ATTRIBUTE);
		changeUnknown(data, OCCUPATION_ATTRIBUTE);
		changeUnknown(data, RELATIONSHIP_ATTRIBUTE);
		changeUnknown(data, RACE_ATTRIBUTE);
		changeUnknown(data, SEX_ATTRIBUTE);
		changeUnknown(data, NATIVE_COUNTRY_ATTRIBUTE);
		
		// replace missing values
		ReplaceMissingValues rep = new ReplaceMissingValues();
		
		rep.setInputFormat(data);
		data = Filter.useFilter(data, rep);
		
		// set class attribute - plus_50
		data.setClassIndex(data.numAttributes()-1);
		
		return data;
	}
	
	public static void main(String[] args) throws Exception {
		if(args.length != 2) {
			System.err.println("usage: C45 <db user> <db password>");
			System.exit(1);
		}
		
		String user = args[0];
		String password = args[1];
		
		Instances train_data = prepareData(TRAIN_QUERY, user, password);
		System.out.println("====================================");
		System.out.println("TRAIN DATA:");
		System.out.println("====================================");
		System.out.println(train_data.toSummaryString());
		
		Instances test_data = prepareData(TEST_QUERY, user, password);
		System.out.println("====================================");
		System.out.println("TEST DATA:");
		System.out.println("====================================");
		System.out.println(test_data.toSummaryString());
		
		// run c4.5
		J48 tree = new J48();
		tree.setOptions(weka.core.Utils.splitOptions("-S -C 0.3"));
		tree.buildClassifier(train_data);
		
		System.out.println(tree.toString());
	
		Evaluation train_eval = new Evaluation(train_data);
		train_eval.evaluateModel(tree, train_data);
		System.out.println(train_eval.toSummaryString("\nTrain Results\n===============\n", false));
	
		Evaluation test_eval = new Evaluation(train_data);
		test_eval.evaluateModel(tree, test_data);
		System.out.println(test_eval.toSummaryString("\nTest Results\n================\n", false));
	}
}
