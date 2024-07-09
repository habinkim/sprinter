package com.habin.sprinter.item.adapter.input;

import com.habin.sprinter.common.stereotype.WebAdapter;
import com.habin.sprinter.item.application.port.input.FileUploadUseCase;
import lombok.RequiredArgsConstructor;

@WebAdapter
@RequiredArgsConstructor
public class FileController {

    private final FileUploadUseCase fileUploadUseCase;

}
