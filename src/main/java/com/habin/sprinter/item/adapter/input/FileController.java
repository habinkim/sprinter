package com.habin.sprinter.item.adapter.input;

import com.habin.sprinter.common.config.Uris;
import com.habin.sprinter.common.stereotype.WebAdapter;
import com.habin.sprinter.item.application.port.input.FileUploadUseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;

@WebAdapter
@RequiredArgsConstructor
public class FileController {

    private final FileUploadUseCase fileUploadUseCase;

    @PostMapping(value = Uris.FILE_V1)
    public void uploadFile() {
        fileUploadUseCase.uploadFile();
    }

}