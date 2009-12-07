import weka.classifiers.Evaluation;
import weka.core.Instances;

public class SimpleCart {
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
		
		weka.classifiers.trees.SimpleCart sc = new weka.classifiers.trees.SimpleCart();
		sc.setUsePrune(true);
		sc.setHeuristic(true);
		sc.setSeed((int)(System.currentTimeMillis() / 1000000));
		sc.buildClassifier(train_data);
		
		System.out.println(sc.toString());
		
		Evaluation train_eval = new Evaluation(train_data);
		train_eval.evaluateModel(sc, train_data);
		System.out.println(train_eval.toSummaryString("\nTrain Results\n===============\n", false));
	
		Evaluation test_eval = new Evaluation(train_data);
		test_eval.evaluateModel(sc, test_data);
		System.out.println(test_eval.toSummaryString("\nTest Results\n================\n", false));

	}
}