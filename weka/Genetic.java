import weka.core.Instances;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.BayesNet;
import weka.filters.Filter;
import weka.filters.unsupervised.instance.RemovePercentage;

public class Genetic {
	public static void main(String[] args) throws Exception {
		if(args.length != 2) {
			System.err.println("usage: C45 <db user> <db password>");
			System.exit(1);
		}
		
		String user = args[0];
		String password = args[1];
	
		
		Instances train_data = Utils.getTrainSet(user, password);
		/*System.out.println("====================================");
		System.out.println("TRAIN DATA:");
		System.out.println("====================================");
		System.out.println(train_data.toSummaryString());
		*/
		Instances test_data = Utils.getTestSet(user, password);
		/*System.out.println("====================================");
		System.out.println("TEST DATA:");
		System.out.println("====================================");
		System.out.println(test_data.toSummaryString());
*/
		RemovePercentage rp = new RemovePercentage();
		rp.setPercentage(99); // usar apenas 1% das instancias
		rp.setInputFormat(train_data);
		Instances new_data = Filter.useFilter(train_data, rp);
		
		BayesNet net = new BayesNet();
		
		String options = "" +
			"-Q weka.classifiers.bayes.net.search.local.GeneticSearch -- -L 3 -A 3 -U 2 -C -M -R 1 " +
			"-E weka.classifiers.bayes.net.estimate.SimpleEstimator -- -A 1.0";
		System.out.println(options);
		
		net.setOptions(weka.core.Utils.splitOptions(options));
		net.buildClassifier(new_data);
		
		System.out.println(net.toString());
	
		Evaluation train_eval = new Evaluation(train_data);
		train_eval.evaluateModel(net, train_data);
		System.out.println(train_eval.toSummaryString("\nTrain Results\n===============\n", false));
	
		Evaluation new_eval = new Evaluation(new_data);
		new_eval.evaluateModel(net, new_data);
		System.out.println(new_eval.toSummaryString("\nNew Results\n===============\n", false));
	
		Evaluation test_eval = new Evaluation(train_data);
		test_eval.evaluateModel(net, test_data);
		System.out.println(test_eval.toSummaryString("\nTest Results\n===============\n", false));
	}
}
