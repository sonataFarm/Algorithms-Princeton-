public class QuickFindUF {
    private int[] id;

    public QuickFindUF(int N) {
        id = new int[N];

        for (int i = 0; i < N; i++)
            id[i] = i;
    }

    public boolean connected(int p, int q) {
        return id[p] == id[q];
    }

    public void union(int p, int q) {
        int pid = id[p];
        int qid = id[q];
        if (pid == qid) {
            return;
        } else {
            for (int i = 0; i < N; i++)
                if (id[i] == pid) id[i] = qid;
        }
    }
}
