package net.shopxx.controller.admin;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Trainv;
import net.shopxx.service.TrainvService;

/**
 * 培训
 * @author wxz
 *
 */
@Controller("adminTrainvController")
@RequestMapping("/admin/trainv")
public class TrainvController extends BaseController{
	
	@Inject
	private TrainvService trainvService;
	
	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		return "admin/trainv/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(Trainv trainv) {
		if (!isValid(trainv)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		trainv.setHits(0L);
		trainvService.save(trainv);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("trainv", trainvService.find(id));
		return "admin/trainv/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(Trainv trainv) {
		if (!isValid(trainv)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		trainvService.update(trainv, "hits");
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", trainvService.findPage(pageable));
		return "admin/trainv/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		trainvService.delete(ids);
		return Results.OK;
	}
}
