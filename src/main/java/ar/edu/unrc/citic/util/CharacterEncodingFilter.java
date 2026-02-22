package ar.edu.unrc.citic.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Filter that sets UTF-8 encoding for all requests and responses.
 * Ensures proper handling of special characters (ñ, á, é, í, ó, ú).
 *
 * @author LearnSpace Team
 * @version 1.0
 */
@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        chain.doFilter(request, response);
    }
}