package com.com.com;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.LocationInfo;
import com.google.protobuf.ByteString;

import DAO.imageMapper;
import VO.MyImage;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	SqlSession sqlSession;
	
	
	String UPLOADPATH = System.getProperty("user.dir") + "\\workspace\\VisionApi\\src\\main\\webapp\\resources\\images\\";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/fileupload", method = RequestMethod.POST)
	public String upload(MultipartFile uploadfile) {
		
		
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid + "_" + uploadfile.getOriginalFilename();
		
		File saveFile = new File(UPLOADPATH, saveFileName);
		
		imageMapper imageManager = sqlSession.getMapper(imageMapper.class);
		
		try {
			uploadfile.transferTo(saveFile);
			MyImage image = new MyImage();
			image.setOriginalFileName(uploadfile.getOriginalFilename());
			image.setChangedFileName(saveFileName);
			imageManager.uploadFile(image);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "home";
	}
	
	
	@RequestMapping(value = "/show", method = RequestMethod.GET)
	public String show(Model model) {
		
		
		imageMapper imageManager = sqlSession.getMapper(imageMapper.class);
		
		List<MyImage> imageList = imageManager.showAll();
		
		List<String> nameList = new ArrayList<String>();
		
		for(int i = 0; i < imageList.size(); i++) {
			nameList.add(imageList.get(i).getChangedFileName());
		}
		
		model.addAttribute("imageList", nameList);
		
		//寃��깋�떆 http://203.233.196.182:8888/hello/resources/images/22f958f3-2704-4a8e-ad4d-3e418fd59c48_bigben2.jpg
		//�떎�쓬怨� 媛숈씠 IP + port + 寃쎈줈瑜� �엯�젰
		/*
		 * https://www.google.co.kr/searchbyimage?site=search&image_url=(寃쎈줈)
		 * http://203.233.196.182:8888/hello/resources/images/22f958f3-2704-4a8e-ad4d-3e418fd59c48_bigben2.jpg
		 * */
		
		
		return "home2";
	}
	
	@RequestMapping(value = "/imagecapture", method = RequestMethod.GET)
	public String imagecapture() {
		return "imagecapture";
	}
	
	@RequestMapping(value = "/capture", method = RequestMethod.POST)
	public String capture(MultipartFile camera, HttpSession session) {
		
		System.out.println(UPLOADPATH);
		
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid + "_" + camera.getOriginalFilename();
		File saveFile = new File(UPLOADPATH, saveFileName);
		imageMapper imageManager = sqlSession.getMapper(imageMapper.class);
		try {
			camera.transferTo(saveFile);
			MyImage image = new MyImage();
			image.setOriginalFileName(camera.getOriginalFilename());
			image.setChangedFileName(saveFileName);
			imageManager.uploadFile(image);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("???");
		
		session.setAttribute("name", saveFileName);
		
		
		return "home3";
	}
	
	@RequestMapping(value = "/result", method = RequestMethod.GET)
	public String result(HttpSession session) {
		
		try {
			detectLandmarks(UPLOADPATH + session.getAttribute("name"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "home4";
	}
	
	/*public static void detectLandmarks(String filePath) throws Exception {
        List<AnnotateImageRequest> requests = new ArrayList<>();

        Image image = getImage(filePath);

        Feature feature = Feature.newBuilder().setType(Feature.Type.LANDMARK_DETECTION).build();
        AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
        requests.add(request);

        try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
            BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
            List<AnnotateImageResponse> responses = response.getResponsesList();

            for (AnnotateImageResponse res : responses) {
                if (res.hasError()) {
                    System.out.println("Error: " + res.getError().getMessage());
                    return;
                }

                // For full list of available annotations, see http://g.co/cloud/vision/docs
                for (EntityAnnotation annotation : res.getLandmarkAnnotationsList()) {
                    LocationInfo info = annotation.getLocationsList().listIterator().next();
                    System.out.println("Landmark: " + annotation.getDescription() + "\n" + "LatLng: " + info.getLatLng());
                }
            }
        }
    }*/
	
	public static Map<String, Object> detectLandmarks(String filePath) throws Exception, IOException {
		Map<String, Object> map = new HashMap<>();
		List<AnnotateImageRequest> requests = new ArrayList<>();
		ByteString imgBytes = ByteString.readFrom(new FileInputStream(filePath));

		Image img = Image.newBuilder().setContent(imgBytes).build();
		Feature feat = Feature.newBuilder().setType(Type.LANDMARK_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				if (res.hasError()) {
					System.out.printf("Error: %s\n", res.getError().getMessage());
				}
				
				System.out.println(res.getLandmarkAnnotationsList().size());

				// For full list of available annotations, see http://g.co/cloud/vision/docs
				for (EntityAnnotation annotation : res.getLandmarkAnnotationsList()) {
					 LocationInfo info = annotation.getLocationsList().listIterator().next();
	                 System.out.println("Landmark: " + annotation.getDescription() + "\n" + "LatLng: " + info.getLatLng());
					//System.out.printf("Landmark: %s\n %s\n", annotation.getDescription(), info.getLatLng());
					
	                String landName = annotation.getDescription();
					double lat = info.getLatLng().getLatitude();
					double lng = info.getLatLng().getLongitude();
					System.out.println(landName + "이름이얏");
					
					map.put("lat", lat);
					map.put("lng", lng);
					map.put("landName", landName);
					
					return map;
				}
			}
		}
		return map;
	}
	
	@RequestMapping(value = "/photoinfo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> hom4(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		
		try {
			map = detectLandmarks(UPLOADPATH + session.getAttribute("name"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
	}
}
