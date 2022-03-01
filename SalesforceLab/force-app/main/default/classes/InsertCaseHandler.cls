public class InsertCaseHandler {
	public static void updateCase (Case caseC) {
		if (caseC.Status == 'Open')
			caseC.Priority = 'Low';
		else caseC.Priority = 'Medium';
	}
}