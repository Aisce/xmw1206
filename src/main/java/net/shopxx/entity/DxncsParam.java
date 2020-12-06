package net.shopxx.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.search.annotations.Indexed;
import org.hibernate.validator.constraints.Length;


/**
 * 电性能参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Indexed
@Entity
public class DxncsParam extends BaseEntity<Long> {

	private static final long serialVersionUID = -4932460099388955597L;

	/**
	 * 绑定产品
	 */
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn()
	private Product product;

	@Length(max = 32)
	private String name;
	
	private String min;
	private String typ;
	private String max;
	
	@Length(max = 20)
	private String unit;

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

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getTyp() {
		return typ;
	}

	public void setTyp(String typ) {
		this.typ = typ;
	}

	public String getMax() {
		return max;
	}

	public void setMax(String max) {
		this.max = max;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}
