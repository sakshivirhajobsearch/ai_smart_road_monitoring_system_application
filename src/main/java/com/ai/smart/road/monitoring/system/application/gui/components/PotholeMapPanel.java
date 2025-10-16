package com.ai.smart.road.monitoring.system.application.gui.components;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.util.List;

import javax.swing.JPanel;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;

public class PotholeMapPanel extends JPanel {
	
	private static final long serialVersionUID = 1L;

	private List<PotholeResponse> potholes;

	public PotholeMapPanel(List<PotholeResponse> potholes) {
		this.potholes = potholes;
		setPreferredSize(new Dimension(600, 400));
		setBackground(Color.WHITE);
	}

	public void setPotholes(List<PotholeResponse> potholes) {
		this.potholes = potholes;
		repaint();
	}

	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
		if (potholes == null || potholes.isEmpty()) {
			g.drawString("No potholes detected", 20, 20);
			return;
		}

		g.setColor(Color.RED);
		for (PotholeResponse p : potholes) {
			int x = (int) p.getX(); // x-coordinate on map
			int y = (int) p.getY(); // y-coordinate on map
			int size = 10; // display size
			g.fillOval(x, y, size, size);
		}
	}
}
