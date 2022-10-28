import java.util.*;

public class Main {

    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        HashMap <String, Term> terms = new HashMap<>();
        boolean isPlaying = true;


        while (isPlaying) {
            clearConsole();
            System.out.println("""
                    Choose one of the following options::
                    1. Add new term:
                        1.1. Add term;
                        1.2. Add sub-term;
                        1.3. Add sub-sub-term;
                    2. Delete term:
                        2.1. delete term;
                        2.2. Delete sub-term;
                        2.3. Delete sub-sub-term;
                    3. Edit page:
                        3.1. Change term's page;
                        3.2. Change sub-term's page;
                        3.3. Change sub-sub-terms page;
                    4. Show all terms;
                    5. Sort term:
                        5.1. Sort terms by alphabet;
                        5.2. Sort terms by page number;
                    6. Find term:
                        6.1. Find term by sub-term;
                        6.2. find sub-term by term;
                    0. Exit.""");
            String option = scanner.nextLine();
            switch (option) {
                case "1.1" -> addTerm(scanner, terms, 1);
                case "1.2" -> addTerm(scanner, terms, 2);
                case "1.3" -> addTerm(scanner, terms, 3);
                case "2.1" -> deleteTerm(scanner, terms, 1);
                case "2.2" -> deleteTerm(scanner, terms, 2);
                case "2.3" -> deleteTerm(scanner, terms, 3);
                case "3.1" -> editPage(scanner, terms, 1);
                case "3.2" -> editPage(scanner, terms, 2);
                case "3.3" -> editPage(scanner, terms, 3);
                case "4" -> showTerms(scanner, terms);
                case "5.1" -> sortTerms(scanner, terms, 1);
                case "5.2" -> sortTerms(scanner, terms, 2);
                case "6.1" -> findTerm(scanner, terms, 1);
                case "6.2" -> findTerm(scanner, terms, 2);
                case "0" -> isPlaying = false;
                default -> {
                    break;
                }
            }
        }
    }

    private static void showTerms(Scanner scanner, HashMap<String, Term> terms) {
        MyHash.showTerms(terms, "");
        System.out.println("Press any character to continue:");
        scanner.next();

    }

    private static void addTerm(Scanner scanner, HashMap<String, Term> terms, int decision) {
        clearConsole();
        switch (decision) {
            case 1 -> {
                System.out.println("Add new term");
                MyHash.addTerm(scanner, terms);
            }

            case 2 -> {
                System.out.println("Add new sub-term");
                System.out.println("Enter term where to add sub-term:");
                String name = scanner.next();
                if (terms.containsKey(name))
                    MyHash.addTerm(scanner, MyHash.getSubTerm(terms, name));
                else {
                    System.out.println(MyConst.RED + "There is no such sub-term" + MyConst.RESET);
                    System.out.println("Press any character to continue:");
                    scanner.next();
                }
            }
            case 3 -> {
                System.out.println("Add new sub-sub-term");
                String[] words = terms.keySet().toArray(new String[0]);
                System.out.println("Enter sub-term where to add sub-sub-term:");
                String sub_name = scanner.next();
                for (int i = 0; i < terms.size(); i++)
                    if (MyHash.getSubTerm(terms, words[i]).containsKey(sub_name))
                        MyHash.addTerm(scanner, MyHash.getSubSubTerm(terms, words[i], sub_name));
                    else {
                        System.out.println(MyConst.RED + "There is no such sub-term" + MyConst.RESET);
                        System.out.println("Press any character to continue:");
                        scanner.next();
                    }


            }
        }
    }

    private static void deleteTerm(Scanner scanner, HashMap<String, Term> terms, int decision) {
        clearConsole();

        switch (decision) {
            case 1 -> {
                System.out.println("Delete term");
                System.out.println("Enter term:");
                String name = scanner.next();
                MyHash.deleteTerm(name, terms);
            }

            case 2 -> {
                System.out.println("Delete sub-term");
                String[] words = terms.keySet().toArray(new String[0]);
                System.out.println("Enter sub-term:");
                String name = scanner.next();
                for (int i = 0; i < terms.size(); i++)
                    MyHash.deleteTerm(name, MyHash.getSubTerm(terms, words[i]));
            }

            case 3 -> {
                System.out.println("Delete sub-sub-term");
                String[] words = terms.keySet().toArray(new String[0]);
                System.out.println("Enter sub-sub-term:");
                String name = scanner.next();
                for (String word : words) {
                    String[] sub_words = MyHash.getSubTerm(terms, word).keySet().toArray(new String[0]);
                    for (String sub_word : sub_words)
                        MyHash.deleteTerm(name, MyHash.getSubSubTerm(terms, word, sub_word));
                }
            }

        }
    }

    private static void findTerm(Scanner scanner, HashMap<String, Term> terms, int decision) {
        clearConsole();
        switch (decision) {

            case 1 -> {
                System.out.println("Find term by sub-term");
                System.out.println("Enter sub-term's name:");
                String name = scanner.next();
                MyHash.findTerm(name, terms);
            }

            case 2 -> {
                System.out.println("Find sub-term by term");
                System.out.println("Enter term's name:");
                String name = scanner.next();
                MyHash.findSubTerm(name, terms);
            }
        }
        System.out.println("Press any character to continue:");
        scanner.next();
    }

    private static void editPage(Scanner scanner, HashMap<String, Term> terms, int decision) {
        clearConsole();

        switch (decision) {
            case 1 -> {
                System.out.println("Edit term");
                System.out.println("Enter term:");
                String name = scanner.next();
                MyHash.changePage(terms.get(name));
            }

            case 2 -> {
                System.out.println("Edit sub-term");
                String[] words = terms.keySet().toArray(new String[0]);
                System.out.println("Enter sub-term:");
                String sub_name = scanner.next();
                Term term = new Term(sub_name, MyHash.addPage());
                for (int i = 0; i < terms.size(); i++)
                    if (MyHash.getSubTerm(terms, words[i]).containsKey(sub_name))
                        MyHash.getSubTerm(terms, words[i]).put(sub_name, term);
            }

            case 3 -> {
                System.out.println("Edit sub-sub-term");
                String[] words = terms.keySet().toArray(new String[0]);
                System.out.println("Enter sub-sub-term:");
                String sub_sub_name = scanner.next();
                Term term = new Term(sub_sub_name, MyHash.addPage());
                for (int i = 0; i < terms.size(); i++)
                    if (MyHash.getSubSubTerm(terms, words[i], sub_sub_name).containsKey(sub_sub_name))
                        MyHash.getSubSubTerm(terms, words[i], sub_sub_name).put(sub_sub_name, term);
            }
        }
    }

    private static void sortTerms(Scanner scanner, HashMap<String, Term> terms, int decision) {
        clearConsole();

        switch (decision) {
            case 1 -> {
                System.out.println("Sort terms by alphabet");
                MyHash.alphabetSort(terms, "");
            }

            case 2 -> {
                System.out.println("Sort terms by page numbers");
                MyHash.pageSort(terms, "");
            }
        }
        System.out.println("Press any character to continue:");
        scanner.next();
    }

    public static void clearConsole()
    {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }
}

