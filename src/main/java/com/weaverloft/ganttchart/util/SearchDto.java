package com.weaverloft.ganttchart.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchDto<E> {
    private List<E> itemList;
    private PageMaker pageMaker;
    private int totCount;
}
