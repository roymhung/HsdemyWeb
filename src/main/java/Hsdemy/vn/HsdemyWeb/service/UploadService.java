package Hsdemy.vn.HsdemyWeb.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {

        // don't upload file
        if (file.isEmpty())
            return "";
        String rootPath = this.servletContext.getRealPath("/resources/images");
        String finalName = "";
        try {
            byte[] bytes = file.getBytes();

            File dir = new File(rootPath + File.separator + targetFolder);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            finalName = finalName.replaceAll("[^a-zA-Z0-9.\\-]", "_");
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);

            BufferedOutputStream stream =
                    new BufferedOutputStream(new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return finalName;
    }

    public void handleDeleteUploadFile(String fileName, String targetFolder) {
        if (fileName == null || fileName.isEmpty())
            return;

        String rootPath = this.servletContext.getRealPath("/resources/images");
        File file = new File(rootPath + File.separator + targetFolder + File.separator + fileName);

        if (file.exists()) {
            file.delete();
        }
    }


}
