import java.util.*;

public class MyHash {

    static HashMap<String, Term> getSubTerm(HashMap <String, Term> terms, String word){
        return terms.get(word).getChildren();
    }

    static HashMap <String, Term> getSubSubTerm(HashMap <String, Term> terms, String word, String sub_word){
        return terms.get(word).getChildren().get(sub_word).getChildren();
    }

    static void alphabetSort(HashMap<String, Term> terms, String space){
        String[] words = terms.keySet().toArray(new String[0]);
        Arrays.sort(words);
        for(int i = 0; i < terms.size(); i++){
            System.out.print(space + words[i] + "  ");
            System.out.println(terms.get(words[i]).getPage());
            alphabetSort(terms.get(words[i]).getChildren(), space + MyConst.SPACE);
        }
    }

    static void pageSort(HashMap<String, Term> terms, String space){
        String[] words = terms.keySet().toArray(new String[0]);
        Arrays.sort(words, (o1, o2) -> {
            int page1 = (int)terms.get(o1).getPage().toArray()[0];
            int page2 = (int)terms.get(o2).getPage().toArray()[0];
            return Integer.compare(page1, page2);
        });
        for(int i = 0; i < terms.size(); i++){
            System.out.print(space + words[i] + "  ");
            System.out.println(terms.get(words[i]).getPage());
            pageSort(terms.get(words[i]).getChildren(), space + MyConst.SPACE);
        }
    }

    static void findSubTerm(String name, HashMap <String, Term> terms){
        System.out.print(name + "  ");
        System.out.println(terms.get(name).getPage());
        if (getSubTerm(terms, name).isEmpty())
            System.out.println(MyConst.RED + "No sub-terms found" + MyConst.RESET);
        else
            showTerms(getSubTerm(terms, name), MyConst.SPACE);
    }

    static void findTerm(String name, HashMap <String, Term> terms){
        String[] words = terms.keySet().toArray(new String[0]);

        for(int i = 0; i < terms.size(); i++){
            if (getSubTerm(terms, words[i]).containsKey(name)) {
                System.out.print(words[i] + "  ");
                System.out.println(terms.get(words[i]).getPage());
                showTerms(getSubTerm(terms, words[i]), MyConst.SPACE);
            }
        }
    }

    static void showTerms(HashMap <String, Term> terms, String space){
        String[] words = terms.keySet().toArray(new String[0]);

        for (int i = 0; i < terms.size(); i++){
            System.out.print(space + words[i] + " = ");
            System.out.println(terms.get(words[i]).getPage());
            showSubTerms(getSubTerm(terms, words[i]), MyConst.SPACE);
        }
    }

    static void showSubTerms(HashMap <String, Term> subterms, String space){
        String[] words = subterms.keySet().toArray(new String[0]);

        for (int i = 0; i < subterms.size(); i++){
            System.out.print(space + words[i] + " = ");
            System.out.println(subterms.get(words[i]).getPage());
            showSubSubTerms(getSubTerm(subterms, words[i]), "    " + MyConst.SPACE);
        }
    }

    static void showSubSubTerms(HashMap <String, Term> subsubterms, String space){
        String[] words = subsubterms.keySet().toArray(new String[0]);

        for (int i = 0; i < subsubterms.size(); i++){
            System.out.print(space + words[i] + " = ");
            System.out.println(subsubterms.get(words[i]).getPage());
            showTerms(getSubTerm(subsubterms, words[i]), "    " + space);
        }
    }

    static void deleteTerm(String name, HashMap <String, Term> terms){
        if (terms.containsKey(name))
            terms.remove(name);
        else
            System.out.println(MyConst.RED + "This word does not exist" + MyConst.RESET);
    }

    static void addTerm(Scanner scanner, HashMap<String, Term> terms){
        System.out.println("Enter name: ");
        String name = scanner.next();
        if (terms.containsKey(name))
            System.out.println(MyConst.RED + "This word is already exists" + MyConst.RESET);
        else {
            Term term = new Term(name, addPage());
            terms.put(name, term);
        }
    }

    static HashSet<Integer> addPage(){
        String answer;
        HashSet <Integer> pages = new HashSet<>();
        boolean isInputPage = true;
        Scanner scanner = new Scanner(System.in);

        while (isInputPage) {
            System.out.println("Enter page: ");
            int add_int = scanner.nextInt();
            pages.add(add_int);
            System.out.println("Add another page? Y/N");
            answer = scanner.next();
            if (Objects.equals(answer, "n") || Objects.equals(answer, "N"))
                isInputPage = false;
        }
        return pages;
    }


    static void changePage(Term term){
        term.setPage(addPage());
    }

}
