package com.eugene.sumarry.mall.common.filter;

import com.eugene.sumarry.jwtutil.entry.JwtSign;
import com.eugene.sumarry.mall.common.constants.Constants;
import com.eugene.sumarry.mall.common.util.SpringContextHolder;
import com.eugene.sumarry.mall.common.web.RequestContext;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

public class JWTAuthFilter extends OncePerRequestFilter {

    private static final Set NOT_AUTH_PATH;

    static {
        NOT_AUTH_PATH = new TreeSet(Arrays.asList(new String[]{
                "/v1/users/login",
                "/v1/goods"
        }));
    }

    @Override
    public void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        Boolean isFilter = needAuth(request.getRequestURI());

        if (isFilter) {

            if (getJwtToken(request) == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "无token");
                return;
            }

            String jwtToken = request.getHeader(Constants.JWT_TOKEN);
            saveCurrentId(jwtToken);
            // logger.info(jwtToken);
        }

        chain.doFilter(request, response);
    }

    private boolean needAuth(String uri) {
        return !NOT_AUTH_PATH.contains(uri);
    }

    @Override
    public void destroy() {
        // Nothing to do
    }

    private String getJwtToken(HttpServletRequest request) {
        return request.getHeader(Constants.JWT_TOKEN);
    }

    private void saveCurrentId(String jwtToken) {
        JwtSign jwtSign = SpringContextHolder.getBean(JwtSign.class);
        Map<String, Object> info = (Map<String, Object>) jwtSign.unSignBody(jwtToken);

        Set<String> keys = info.keySet();
        Iterator<String> iterator = keys.iterator();
        // 第一个key对应的value为自定义数据
        String key = iterator.hasNext() ? iterator.next() : null;

        if (key != null) {
            Map<String, Object> map = (Map)info.get(key);
            Integer userId = (Integer)map.get(Constants.USER_ID);
            RequestContext.saveCurrentId(userId.longValue());
        }
    }

}
