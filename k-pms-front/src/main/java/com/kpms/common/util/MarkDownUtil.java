package com.kpms.common.util;

import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;

public class MarkDownUtil {
	private static HtmlRenderer renderer;
	private static Parser parser;
	
	static {
		renderer = HtmlRenderer.builder().build();
		parser = Parser.builder().build();
	}
	
	public static String mdToHtml(String str) {
		Node document = parser.parse(str.replaceAll("\n", "\n\n"));
		return renderer.render(document);
	}
	
}
