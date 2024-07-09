package com.habin.sprinter.item.application.service;

import com.habin.sprinter.common.stereotype.UseCase;
import com.habin.sprinter.item.application.port.input.FileUploadUseCase;
import com.habin.sprinter.item.application.port.output.SaveItemResourcePort;
import lombok.RequiredArgsConstructor;

@UseCase
@RequiredArgsConstructor
public class FileUploadService implements FileUploadUseCase {

    private final SaveItemResourcePort saveItemResourcePort;


}
