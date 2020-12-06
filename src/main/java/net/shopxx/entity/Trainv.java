package net.shopxx.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Boost;
import org.hibernate.search.annotations.DateBridge;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Resolution;
import org.hibernate.search.annotations.SortableField;
import org.hibernate.search.annotations.Store;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.nodes.TextNode;

import com.fasterxml.jackson.annotation.JsonView;

import net.shopxx.audit.CreatedDate;

/**
 * 培训
 * @author wxz
 *
 */
@Indexed
@Entity
public class Trainv extends BaseEntity<Long>{

	private static final long serialVersionUID = -6436859844893749541L;
	
	/**
	 * 点击数缓存名称
	 */
	public static final String HITS_CACHE_NAME = "trainvHits";
	
	/**
	 * 路径
	 */
	private static final String PATH = "/trainv/detail/%d_%d";
	
	/**
	 * 内容分页长度
	 */
	private static final int PAGE_CONTENT_LENGTH = 2000;

	/**
	 * 内容分页标签
	 */
	private static final String PAGE_BREAK_TAG = "shopxx_page_break_tag";

	/**
	 * 段落配比
	 */
	private static final Pattern PARAGRAPH_PATTERN = Pattern.compile("[^,;\\.!?，；。！？]*([,;\\.!?，；。！？]+|$)");
	
	/**
	 * 主题
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Boost(1.5F)
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false)
	private String subject;
	
	/**
	 * 主办方
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.NO, analyze = Analyze.NO)
	@Length(max = 200)
	private String sponsor;
	
	/**
	 * 简介
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@NotEmpty
	@Length(max = 500)
	@Column(nullable = false)
	private String synopsis;
	
	/**
	 * 内容
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Lob
	private String content;
	
	/**
	 * 是否发布
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull
	@Column(nullable = false)
	private Boolean isPublication;

	/**
	 * 是否置顶
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@SortableField
	@NotNull
	@Column(nullable = false)
	private Boolean isTop;

	/**
	 * 点击数
	 */
	@Column(nullable = false)
	private Long hits;
	
	/**
	 * 报名开始时间
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@DateBridge(resolution = Resolution.SECOND)
	@SortableField
	@Column(nullable = false, updatable = false)
	private Date bmStartDate;
	
	/**
	 * 报名结束时间
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@DateBridge(resolution = Resolution.SECOND)
	@SortableField
	@Column(nullable = false, updatable = false)
	private Date bmEndDate;
	
	/**
	 * 培训开始时间
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@DateBridge(resolution = Resolution.SECOND)
	@SortableField
	@Column(nullable = false, updatable = false)
	private Date pxStartDate;
	
	/**
	 * 培训结束时间
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@DateBridge(resolution = Resolution.SECOND)
	@SortableField
	@Column(nullable = false, updatable = false)
	private Date pxEndDate;
	/**
	 *   地点
	 */
	@Column(nullable = false)
	private String address;

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getSponsor() {
		return sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}

	public String getSynopsis() {
		return synopsis;
	}

	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getIsPublication() {
		return isPublication;
	}

	public void setIsPublication(Boolean isPublication) {
		this.isPublication = isPublication;
	}

	public Boolean getIsTop() {
		return isTop;
	}

	public void setIsTop(Boolean isTop) {
		this.isTop = isTop;
	}

	public Long getHits() {
		return hits;
	}

	public void setHits(Long hits) {
		this.hits = hits;
	}
	
	public Date getBmStartDate() {
		return bmStartDate;
	}

	public void setBmStartDate(Date bmStartDate) {
		this.bmStartDate = bmStartDate;
	}

	public Date getBmEndDate() {
		return bmEndDate;
	}

	public void setBmEndDate(Date bmEndDate) {
		this.bmEndDate = bmEndDate;
	}

	public Date getPxStartDate() {
		return pxStartDate;
	}

	public void setPxStartDate(Date pxStartDate) {
		this.pxStartDate = pxStartDate;
	}

	public Date getPxEndDate() {
		return pxEndDate;
	}

	public void setPxEndDate(Date pxEndDate) {
		this.pxEndDate = pxEndDate;
	}

	/**
	 * 获取路径
	 * 
	 * @return 路径
	 */
	@JsonView(BaseView.class)
	@Transient
	public String getPath() {
		return getPath(1);
	}

	/**
	 * 获取路径
	 * 
	 * @param pageNumber
	 *            页码
	 * @return 路径
	 */
	@Transient
	public String getPath(Integer pageNumber) {
		return String.format(Trainv.PATH, getId(), pageNumber);
	}
	
	/**
	 * 获取分页内容
	 * 
	 * @return 分页内容
	 */
	@Transient
	public String[] getPageContents() {
		if (StringUtils.isEmpty(getContent())) {
			return new String[] { StringUtils.EMPTY };
		}
		if (StringUtils.contains(getContent(), PAGE_BREAK_TAG)) {
			return StringUtils.splitByWholeSeparator(getContent(), PAGE_BREAK_TAG);
		}
		List<Node> childNodes = Jsoup.parse(getContent()).body().childNodes();
		if (CollectionUtils.isEmpty(childNodes)) {
			return new String[] { getContent() };
		}
		List<String> pageContents = new ArrayList<>();
		int textLength = 0;
		StringBuilder paragraph = new StringBuilder();
		for (Node node : childNodes) {
			if (node instanceof Element) {
				Element element = (Element) node;
				paragraph.append(element.outerHtml());
				textLength += element.text().length();
				if (textLength >= PAGE_CONTENT_LENGTH) {
					pageContents.add(String.valueOf(paragraph));
					textLength = 0;
					paragraph.setLength(0);
				}
			} else if (node instanceof TextNode) {
				TextNode textNode = (TextNode) node;
				Matcher matcher = PARAGRAPH_PATTERN.matcher(textNode.text());
				while (matcher.find()) {
					String content = matcher.group();
					paragraph.append(content);
					textLength += content.length();
					if (textLength >= PAGE_CONTENT_LENGTH) {
						pageContents.add(String.valueOf(paragraph));
						textLength = 0;
						paragraph.setLength(0);
					}
				}
			}
		}
		String pageContent = paragraph.toString();
		if (StringUtils.isNotEmpty(pageContent)) {
			pageContents.add(pageContent);
		}
		return pageContents.toArray(new String[pageContents.size()]);
	}

	/**
	 * 获取分页内容
	 * 
	 * @param pageNumber
	 *            页码
	 * @return 分页内容
	 */
	@Transient
	public String getPageContent(Integer pageNumber) {
		if (pageNumber == null || pageNumber < 1) {
			return null;
		}
		String[] pageContents = getPageContents();
		if (pageContents.length < pageNumber) {
			return null;
		}
		return pageContents[pageNumber - 1];
	}

	/**
	 * 获取总页数
	 * 
	 * @return 总页数
	 */
	@Transient
	public int getTotalPages() {
		return getPageContents().length;
	}
}
