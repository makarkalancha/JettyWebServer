package webapp.servlet;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.math.NumberUtils;
import webapp.objects.SomeClass;

/**
 * Created by mcalancea on 2016-03-08.
 */
public class TableServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = NumberUtils.toLong(req.getParameter("calculatedColumnId"));
        Long agencyId = NumberUtils.toLong(req.getParameter("agencyId"));
        Long accountId = NumberUtils.toLong(req.getParameter("accountId"));
        String formulaName = req.getParameter("formulaName");
        String formula = req.getParameter("formula");
        String execAction = req.getParameter("execAction");
        Boolean isActive = BooleanUtils.toBoolean(req.getParameter("isActive"));
        if(agencyId > 0L && accountId > 0L ) {
            SomeClass someClass1 = new SomeClass();
            someClass1.setId(1L);
            someClass1.setFormulaName("name");
            someClass1.setFormula("formula");
            someClass1.setActive(true);

            SomeClass someClass2 = new SomeClass();
            someClass2.setId(2L);
            someClass2.setFormulaName("name2");
            someClass2.setFormula("formula2");
            someClass2.setActive(false);

            List<SomeClass> someClasses = new ArrayList<>();
            someClasses.add(someClass1);
            someClasses.add(someClass2);

            if(id > 0L){
                SomeClass someClass3 = new SomeClass();
                someClass3.setId(id);
                someClass3.setFormulaName(formulaName);
                someClass3.setFormula(formula);
                someClass3.setActive(isActive);

                someClasses.add(someClass3);
            }

//        Gson gson = new Gson();
//        String json = gson.toJson(someClasses);
//        System.out.println(json);

            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.print(new Gson().toJson(someClasses));
            out.close();
        }
    }

}
