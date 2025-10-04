package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {
    
    private String encoding = "UTF-8";
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String encodingParam = filterConfig.getInitParameter("encoding");
        if (encodingParam != null && !encodingParam.trim().isEmpty()) {
            this.encoding = encodingParam;
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        // Set request encoding
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        
        // Set response encoding
        response.setCharacterEncoding(encoding);
        
        // Set content type for HTML responses
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            
            String requestURI = httpRequest.getRequestURI();
            if (requestURI.endsWith(".jsp") || requestURI.endsWith(".html")) {
                httpResponse.setContentType("text/html;charset=" + encoding);
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Clean up resources if needed
    }
}
