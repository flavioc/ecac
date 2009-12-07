import weka.classifiers.Evaluation;
import weka.core.Instances;


public class ADTree {
	public static void main(String []args) throws Exception {
		if(args.length != 2) {
			System.err.println("usage: C45 <db user> <db password>");
			System.exit(1);
		}

		String user = args[0];
		String password = args[1];

		Instances train_data = Utils.getTrainSet(user, password);
		System.out.println("====================================");
		System.out.println("TRAIN DATA:");
		System.out.println("====================================");
		System.out.println(train_data.toSummaryString());

		Instances test_data = Utils.getTestSet(user, password);
		System.out.println("====================================");
		System.out.println("TEST DATA:");
		System.out.println("====================================");
		System.out.println(test_data.toSummaryString());
		
		weka.classifiers.trees.ADTree adt = new weka.classifiers.trees.ADTree();
		
		adt.setRandomSeed((int)(System.currentTimeMillis() / 1000000));
		adt.setNumOfBoostingIterations(40);
		adt.buildClassifier(train_data);
		
		System.out.println(adt.toString());
		
		Evaluation train_eval = new Evaluation(train_data);
		train_eval.evaluateModel(adt, train_data);
		System.out.println(train_eval.toSummaryString("\nTrain Results\n===============\n", false));
	
		Evaluation test_eval = new Evaluation(train_data);
		test_eval.evaluateModel(adt, test_data);
		System.out.println(test_eval.toSummaryString("\nTest Results\n================\n", false));

	}
}
