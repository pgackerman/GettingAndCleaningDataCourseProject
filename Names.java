public class Names
{
    public static void main(java.lang.String[] args) throws java.lang.Exception
    {
        Names pgm = new Names();
    }

    private Names() throws java.lang.Exception
    {
        java.io.BufferedWriter out = new java.io.BufferedWriter(new java.io.FileWriter("d:\\git\\gettingandcleaningdatacourseproject\\names.out"));
        java.io.BufferedReader in = new java.io.BufferedReader(new java.io.FileReader("d:\\git\\gettingandcleaningdatacourseproject\\names.txt"));
        for (java.lang.String line; (line = in.readLine()) != null;)
        {
            if (line.toLowerCase().contains("mean") || line.toLowerCase().contains("std"))
            {
                out.write(line);
                out.newLine();
            }
        }
        in.close();
        out.close();
    }
}
