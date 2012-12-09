package cn.jcenterhome.web.filter;
import java.io.IOException;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.jcenterhome.util.Common;
import cn.jcenterhome.util.JavaCenterHome;
import cn.jcenterhome.util.PropertiesHelper;
import cn.jcenterhome.web.servlet.HttpServletRequestWrapper;
public class InitFilter implements Filter {
	public void init(FilterConfig fc) throws ServletException {
	}
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,
			ServletException {
		HttpServletRequestWrapper request=new HttpServletRequestWrapper((HttpServletRequest) req);
		HttpServletResponse response = (HttpServletResponse) res;
		request.setCharacterEncoding(JavaCenterHome.JCH_CHARSET);
		response.setCharacterEncoding(JavaCenterHome.JCH_CHARSET);				//jchRoot===D:\Apache\apache-tomcat-6.0.32\webapps\JavaCenter\
		if (JavaCenterHome.jchRoot == null) {
			JavaCenterHome.setJchRoot(request);  //��ʼ��jchRoot
		}				//JavaCenterHome.jchConfig��ŵ���config.properties�����ļ����������
		Map<String, String> jchConfig = JavaCenterHome.jchConfig;
		if (jchConfig.isEmpty()) {
			try {
				initConfig(request, jchConfig);//��ʼ��jchConfig
			} catch (IOException e) {
				response.getWriter().write("��ȡ�����ļ�(./config.properties)����" + e.getMessage());
				return;
			}
		}
		chain.doFilter(request, res);
	}
	private synchronized void initConfig(HttpServletRequest request, Map<String, String> jchConfig)
			throws IOException {
		PropertiesHelper propHelper = new PropertiesHelper(JavaCenterHome.jchRoot + "config.properties");
		Properties config = propHelper.getProperties();
		Set<Object> keys = config.keySet();
		for (Object key : keys) {
			String k = (String) key;
			String v = (String) config.get(key);
			jchConfig.put(k, v);			//System.out.println("key=" + k + ":value=" + v);
		}		//Common.getSiteUrl(request)===http://localhost:8080/JavaCenter/
		String siteUrl = jchConfig.get("siteUrl");
		if (Common.empty(siteUrl)) {
			jchConfig.put("siteUrl", Common.getSiteUrl(request));			//System.out.println("Common.getSiteUrl(request)===" + Common.getSiteUrl(request));
		}
		ServletContext servletContext=request.getSession().getServletContext();
		servletContext.setAttribute("jchConfig", JavaCenterHome.jchConfig);
	}
	public void destroy() {
	}
}