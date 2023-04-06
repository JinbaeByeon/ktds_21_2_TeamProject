package com.kpms.emp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.emp.dao.EmpDAO;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;
}
