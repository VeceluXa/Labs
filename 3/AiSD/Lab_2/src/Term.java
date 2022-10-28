import java.util.HashMap;
import java.util.Set;

class Term{

    private final String name;

    private Set<Integer> page;

    private final HashMap<String, Term> children;

    public Set<Integer> getPage(){
        return page;
    }

    public void setPage(Set<Integer> page){
        this.page = page;
    }

    public HashMap<String, Term> getChildren() {
        return children;
    }

    public Term(String name, Set<Integer> page){
        this.name = name;
        this.page = page;
        children = new HashMap<>();
    }

    @Override
    public int hashCode(){
        return name.hashCode();
    }

    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Term term = (Term) o;
        return name.equals(term.name);
    }
}