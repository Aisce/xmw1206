package net.shopxx.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;

/**
 * 类似产品参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Indexed
@Entity
public class ProductParam extends BaseEntity<Long> {

	private static final long serialVersionUID = -9098955961403825943L;

	/**
	 * 绑定产品
	 */
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn()
	private Product product;

	public enum Type {
		/**
		 * 其它环境适应性指标
		 */
		QTHJSYXZB,
		/**
		 * 参数绝对最大额定值
		 */
		CSJDZDEDZ,
		/**
		 * 推荐工作参数
		 */
		TJGZCS,
		/**
		 * 兼容国外型号生产厂家
		 */
		JRGWXH
	}

	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull(groups = Save.class)
	@Column(nullable = false, updatable = false)
	private Type type;

	@Length(max = 32)
	private String name;//参数值
	@Length(max = 20)
	private String value1;//额定值
	@Length(max = 20)
	private String value2;//最小值 //生产厂家代码
	@Length(max = 20)
	private String value3;//最大值//进口封装形式
	
	@Length(max = 20)
	private String value4;//进口名称
	
	@Length(max = 20)
	private String value5;//进口质量等级

	@Length(max = 20)
	private String unit;//单位 //进口封装管脚数

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue1() {
		return value1;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}
	
	public String getValue2() {
		return value2;
	}

	public String getValue4() {
		return value4;
	}

	public void setValue4(String value4) {
		this.value4 = value4;
	}

	public String getValue5() {
		return value5;
	}

	public void setValue5(String value5) {
		this.value5 = value5;
	}

	public void setValue2(String value2) {
		this.value2 = value2;
	}

	public String getValue3() {
		return value3;
	}

	public void setValue3(String value3) {
		this.value3 = value3;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

}
