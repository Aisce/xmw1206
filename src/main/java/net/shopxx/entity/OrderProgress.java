package net.shopxx.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

/**
 * 订单进度
 * 
 * @author wxz
 *
 */
@Entity
public class OrderProgress extends BaseEntity<Long> {

	private static final long serialVersionUID = 3504873053425682424L;

	/**
	 * 产品
	 */
	@NotNull(groups = Save.class)
	@ManyToOne(fetch = FetchType.LAZY)
	private Product product;

	/**
	 * 订单
	 */
	@NotNull(groups = Save.class)
	@ManyToOne(fetch = FetchType.LAZY)
	private Order order;

	/**
	 * 进度信息内容
	 */
	@NotNull
	@Length(max = 255)
	private String content;

	/**
	 * 备注
	 */
	@Length(max = 255)
	private String remark;

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
