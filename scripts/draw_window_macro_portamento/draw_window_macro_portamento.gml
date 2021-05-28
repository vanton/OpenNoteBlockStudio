function draw_window_macro_portamento() {
	// draw_window_portamento()
	var x1, y1, a, b, str, total_vals, val, decr, inc;
	if (theme = 3) draw_set_alpha(windowalpha)
	curs = cr_default
	text_exists[0] = 0
	if (selected = 0) return 0
	x1 = floor(rw / 2 - 80)
	y1 = floor(rh / 2 - 80)
	draw_window(x1, y1, x1 + 140, y1 + 130)
	draw_set_font(fnt_mainbold)
		if (theme = 3) draw_set_font(fnt_wslui_bold)
	draw_text(x1 + 8, y1 + 8, "Portamento")
	draw_set_font(fnt_main)
		if (theme = 3) draw_set_font(fnt_wslui)
	if (theme = 0) {
	    draw_set_color(c_white)
	    draw_rectangle(x1 + 6, y1 + 26, x1 + 134, y1 + 92, 0)
	    draw_set_color(make_color_rgb(137, 140, 149))
	    draw_rectangle(x1 + 6, y1 + 26, x1 + 134, y1 + 92, 1)
	}
	if (draw_checkbox(x1 + 10, y1 + 30, porta_reverse, "Reversed", "Portamento is done in the inverse direction.")) porta_reverse=!porta_reverse
	draw_areaheader(x1 + 10, y1 + 53, 120, 35, "Cent shift")
	port_cent = median(-1200, draw_dragvalue(11, x1 + 55, y1 + 65, port_cent, 0.1), 1200)

	draw_theme_color()
	if (draw_button2(x1 + 10, y1 + 98, 60, "OK")) {
		windowalpha = 0
		windowclose = 0
		windowopen = 0
		str = selection_code
		val = 0
		decr = port_cent / string_count("-1", str)
		inc = decr
		arr_data = selection_to_array(str)
		window = 0
		total_vals = string_count("|", str)
		val = 0
		while (val < total_vals) {
			val += 6
			if porta_reverse = 1 {
				arr_data[real(val)] = real(port_cent) + real(decr)
			} else arr_data[real(val)] = real(arr_data[real(val)]) + real(decr)
			val ++
			while arr_data[val] != -1 {
				val += 5
				if porta_reverse = 1 {
					arr_data[real(val)] = real(port_cent) + real(decr)
				} else arr_data[real(val)] = real(arr_data[real(val)]) + real(decr)
				val ++
			}
			if porta_reverse = 1 {
				decr = decr - inc
			} else decr = decr + inc
			val ++
		}
		str = array_to_selection(arr_data, total_vals)
		selection_load(selection_x,selection_y,str,true)
		if(!keyboard_check(vk_alt)) selection_place(false)
	}
	if (draw_button2(x1 + 70, y1 + 98, 60, "Cancel") && windowopen = 1) {windowclose = 1}
	window_set_cursor(curs)
	window_set_cursor(cr_default)
	if (windowopen = 0 && theme = 3) {
		if (windowalpha < 1) {
			if (refreshrate = 0) windowalpha += 1/3.75
			else if (refreshrate = 1) windowalpha += 1/7.5
			else if (refreshrate = 2) windowalpha += 1/15
			else if (refreshrate = 3) windowalpha += 1/18
			else windowalpha += 1/20
		} else {
			windowalpha = 1
			windowopen = 1
		}
	}
	if(theme = 3) {
		if (windowclose = 1) {
			if (windowalpha > 0) {
				if (refreshrate = 0) windowalpha -= 1/3.75
				else if (refreshrate = 1) windowalpha -= 1/7.5
				else if (refreshrate = 2) windowalpha -= 1/15
				else if (refreshrate = 3) windowalpha -= 1/18
				else windowalpha -= 1/20
			} else {
				windowalpha = 0
				windowclose = 0
				windowopen = 0
				window = 0
				window_set_cursor(curs)
				save_settings()
			}
		}
	} else {
		if (windowclose = 1) {
			windowclose = 0
			window = 0
		}
	}
	draw_set_alpha(1)

}
