//public class QuickFindUF {
//    private int[] id;
//
//    public QuickFindUF(int N) {
//        id = new int[N];
//
//        for (int i = 0; i < N; i++)
//            id[i] = i;
//    }
//
//    public boolean connected(int p, int q) {
//        return id[p] == id[q];
//    }
//
//    public void union(int p, int q) {
//        int pid = id[p];
//        int qid = id[q];
//        if (pid == qid) {
//            return;
//        } else {
//            for (int i = 0; i < N; i++)
//                if (id[i] == pid) id[i] = qid;
//        }
//    }
//}

public class QuickUnionUF {
    private int[] id;

    public QuickUnionUF(int N) {
        id = new int[N];

        for (int i = 0; i < N; i++)
            id[i] = i;
    }

    public boolean connected(int p, int q) {
        return root(p) == root(q);
    }

    public void union(int p, int q) {
        int pRoot = root(p);
        int qRoot = root(q);
        id[pRoot] = qRoot;
    }

    public int root(int i) {
        while (id[i] != i) {
            id[i] = id[id[i]];
            i = id[i];
        }
        return i;
    }

    public static void main(String[] args) {
        QuickUnionUF uf = new QuickUnionUF(100);
        uf.union(0, 1);
        uf.union(0, 2);
        System.out.println(uf.connected(0, 3));
    }
}
