Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7809287505
	for <linux-hexagon@vger.kernel.org>; Wed,  7 Jan 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770991; cv=pass; b=F1QwOVsS8opf3YTfxRf+UiIlH8EZ/61+puLdpnsdoWG4clByZoihX1qv/jNBo98bLyobrkp9zwR+Us+PMsSENV94jGafXrRcfgHeGI1CKPlU6Oeit1opcn7dcWR3go4C/FS5xUE1+saEyd9Bd1Nv91/g4eqX9IEhxvlDyZCDywc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770991; c=relaxed/simple;
	bh=FiJtxBI078l8SBgafpa2/ZVIdEmusV8YUBLBhKfT+zw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ya1WZg4dkw+7FRTjgNUCY7kdpbSJKdyJUngIX3mFTEDOb48lLDiRTHNm6VwBDe4ZfdXGtquT3FkAmq6GLEQL3Of59/gKZ/VoAjGjYImUYc+WL3UniDSwJ0XMIdb8JzgRfclWDXxtXto/1xbOsbVOlSrRQ1esNHIdd2mJDto7fYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=N8oLApD7; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="N8oLApD7"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6EA3B46120D
	for <linux-hexagon@vger.kernel.org>; Wed, 07 Jan 2026 07:20:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.106.235.176])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7370C4612EF
	for <linux-hexagon@vger.kernel.org>; Wed, 07 Jan 2026 07:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1767770407;
	b=d+opvtXJ8T2OhURPBWC8qj0edEQyT7W21z4A6grxYE5chvs+Yu1BtHMnb/pDp1ZmEHO7iU
	a0qggTuzgM5oDvWLYXbJ1jbKUI5qEZ8DKkMYXJglGRHSgTOtVk8oz7VMTdsvFJq8bh4Y4H
	FDi5+DMYM4puxy1sOtR+5NNLuaFrrrLTPUYsApCK+XseBZm+UvtNzxoAfS1KU3oIbBQ8FK
	/qCxdJZyx+e6r36UHu1j8tkdRkknLkgMuAw22rC4LUw1mj0ZU1Nf86bjkxHcf0wb/Ush7b
	IuAQjvK61YaMwolqGhTxD2vGNpRU7qlWAtu0IK0DJC6gevVEB+yILp2l82lWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1767770407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=FiJtxBI078l8SBgafpa2/ZVIdEmusV8YUBLBhKfT+zw=;
	b=GCxtYrzXBI9kNpDFyApF7PFGotejkPW1S/MUnehvFzMt9hytFAY+OhIMMzl8B65zjhzFrY
	M7p16a2HUX8qTAfPrBaWWuCqow/pv6vc2Y8BHotYCspLyURRMpylj+yx7qKd5anppHUdxl
	I6S3XU3pY86y290K59DEPqrMaUQnUKffMJAZPAsmPYqaYyvxoVs/5oflOm02LCOxqW+WSS
	4aXhpF+ESji1ys3YCHig4Zs0GAWLV7TkD0+bA1MSaaLUN1Ah/mwhh9zIUUdfkeeRtFjoKP
	SDnHSfevE5NO0/ccriF1bdus7WLbh3Yx52qxlx15F5rgwWBaS8LG5Gusyzb91w==
ARC-Authentication-Results: i=1;
	rspamd-69599c6f48-s6x4t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Attack: 2a5056ec041e0e4f_1767770409926_2292125598
X-MC-Loop-Signature: 1767770409926:2858887034
X-MC-Ingress-Time: 1767770409924
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.235.176 (trex/7.1.3);
	Wed, 07 Jan 2026 07:20:09 +0000
Received: from [IPV6:2607:fb90:9a98:b4a:ee1c:ff6f:1018:9809] (unknown [172.58.11.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4dmKDl0c4RzT1
	for <linux-hexagon@vger.kernel.org>; Tue,  6 Jan 2026 23:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1767770407;
	bh=FiJtxBI078l8SBgafpa2/ZVIdEmusV8YUBLBhKfT+zw=;
	h=Date:To:From:Subject:Content-Type:Content-Transfer-Encoding;
	b=N8oLApD7xtFKoHPpysdNc1lObtoDKQ0XEeYWG5wbnorY5UZ4o6CVJZod8bGKUWGjC
	 JE2IJNrvjUiu1HzMcXk7KbGlMEnVW5tnxDfEUSxu00w/a9CUjUyP2Rf4O6lUlUZ4Dn
	 d8FWJ5e0iOgeaoXnSsobgE+LHpDh1FIS0zWx5oJqk8dUuLbX9oOK6qIfmvIkq6ver9
	 uvZVn9Dwqo1fPQxAk+LfpvkMy+c6UrQsxvRwquNNuvibv63YDFyN06cxirxRpmkleD
	 x5MpVDpLFMe25bvCRduyJK28xJcVHD+V49TTk8FD1d+lNxQv2zfdmLM977rJPVdqGG
	 Qmxd+/hj5wOXA==
Message-ID: <68f83fb5-4564-4bae-b214-44cbf2a3a4bc@landley.net>
Date: Wed, 7 Jan 2026 01:20:03 -0600
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hexagon@vger.kernel.org
Content-Language: en-US
From: Rob Landley <rob@landley.net>
Subject: Hexagon wikipedia article deleted?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Was there a reason...?

https://en.wikipedia.org/w/index.php?title=Special:Log/delete&page=Qualcomm_Hexagon

Rob
