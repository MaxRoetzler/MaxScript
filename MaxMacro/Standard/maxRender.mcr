macroScript MaxRender category:"Max Core" buttonText:"Render" toolTip:"Render"
(
	local count = SysInfo.CpuCount;
	local index = Random 1 count;

	for cpu = 1 to count do
	(
		SysInfo.ProcessAffinity = bit.Set SysInfo.ProcessAffinity cpu (cpu != index);
	)

	local viewData = Core.Util.ViewData ();
	local renderCamera = Viewport.GetCamera ();

	-- Try to find active camera
	if (renderCamera == undefined) then
	(
		for sceneCamera in $cameras while (renderCamera == undefined) do
		(
			-- Filter camera targets
			if (SuperClassOf sceneCamera == Camera) do
			(
				renderCamera = sceneCamera;
				Viewport.SetCamera sceneCamera;
			)
		)
	)

	max Quick Render();
	viewData.Reset ();
)