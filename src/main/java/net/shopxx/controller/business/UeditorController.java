package net.shopxx.controller.business;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baidu.ueditor.ActionEnter;

import net.shopxx.FileType;
import net.shopxx.controller.admin.BaseController;
import net.shopxx.service.FileService;

@Controller("commonUeditorController")
@RequestMapping("/common/ueditor")
public class UeditorController extends BaseController {

	@Inject
	private FileService fileService;
	
	@GetMapping("/config")
	@ResponseBody
	public String config(HttpServletRequest request) {
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		return new ActionEnter(request, rootPath).exec();
	}
	
	@PostMapping("/upload_image")
	public @ResponseBody Map<String, Object> uploadImage(HttpServletRequest request, MultipartFile file) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			// 判断文件是否为空
			if (!file.isEmpty()) {
				String url = fileService.upload(FileType.IMAGE, file, false);
				rs.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
				rs.put("url", url); // 能访问到你现在图片的路径
				rs.put("title", file.getOriginalFilename());
				rs.put("original", file.getOriginalFilename());
			}
		} catch (Exception e) {
			rs.put("state", "文件上传失败!"); // 在此处写上错误提示信息，这样当错误的时候就会显示此信息
			rs.put("url", "");
			rs.put("title", "");
			rs.put("original", "");
		}
		return rs;
	}
	
	@PostMapping("/upload_file")
	public @ResponseBody Map<String, Object> uploadFile(HttpServletRequest request, MultipartFile file) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			// 判断文件是否为空
			if (!file.isEmpty()) {
				String url = fileService.upload(FileType.FILE, file, false);
				rs.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
				rs.put("url", url); // 能访问到你现在文件的路径
				rs.put("title", file.getOriginalFilename());
				rs.put("original", file.getOriginalFilename());
			}
		} catch (Exception e) {
			rs.put("state", "文件上传失败!"); // 在此处写上错误提示信息，这样当错误的时候就会显示此信息
			rs.put("url", "");
			rs.put("title", "");
			rs.put("original", "");
			e.printStackTrace();
		}
		return rs;
	}

	@PostMapping("/upload_video")
	public @ResponseBody Map<String, Object> uploadVideo(HttpServletRequest request, MultipartFile file) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			// 判断文件是否为空
			if (!file.isEmpty()) {
				String url = fileService.upload(FileType.MEDIA, file, false);
				rs.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
				rs.put("url", url); // 能访问到你现在文件的路径
				rs.put("title", file.getOriginalFilename());
				rs.put("original", file.getOriginalFilename());
			}
		} catch (Exception e) {
			rs.put("state", "文件上传失败!"); // 在此处写上错误提示信息，这样当错误的时候就会显示此信息
			rs.put("url", "");
			rs.put("title", "");
			rs.put("original", "");
			e.printStackTrace();
		}
		return rs;
	}
}
