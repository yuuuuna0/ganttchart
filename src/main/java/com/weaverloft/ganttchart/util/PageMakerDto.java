package com.weaverloft.ganttchart.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageMakerDto<E> {
    private List<E> itemList;
    private PageMaker pageMaker;
    private int totRecordCount;
}
