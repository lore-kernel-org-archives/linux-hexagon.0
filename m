Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C730CDBD;
	Mon, 22 Dec 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395436; cv=none; b=H0TA8E7y3NXJCuV66rmo7AGMA8h4THAcHyzVtcXPfmasXGfhYbRmCkLCek5cDlhhi9ZemCf1pbiWXaxg7oU89ZMEJ980fBSqJt/O6EaUhWRRrGZgmHn34GKbl6zYsgMC9ogNrExSkCE4OXFNOXe64lxBSLNdZNTshBCy0VEqiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395436; c=relaxed/simple;
	bh=uRBVWAiaGAON24PWb1hMShWdsmQROohqUGwoUEzvwLY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CUmfOkKWRQ+/q+Nja+OeCmmfOfWa5lVyKsG6JpAyWcE6VYZ9zoopAzIJRQOXONWvJPeMdO32YSp8Ub0tEmfsLRSvDsURMRE28PABYC7ZR2edj8c7W1X08EU6MGJDvmZ9ho/LIUApV1kezeeRC+y+JeONcfXJqLzizVlfIj6FGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CFh/zBWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xt2cddAH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CFh/zBWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xt2cddAH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B80E27A006A;
	Mon, 22 Dec 2025 04:23:53 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 04:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766395433;
	 x=1766481833; bh=uRBVWAiaGAON24PWb1hMShWdsmQROohqUGwoUEzvwLY=; b=
	CFh/zBWHfQLe5TUcm5DRrY01VNYR7ezjcd1lW89pDzZKnzGp1TnTdwceK8eucyG2
	+ClPnyYHgloycpkfSV3ae8CSjylU6adc1H9pM/hZJgf+Hi8EJToroRBqpcxBBtWr
	pRK7cG+CJ4MTHejEWAsdiPyt5Mw36qY8snoreKKBRAX0zMViTbjtGuSrJUOdZjl9
	heVVZ/9OEb3lA6XQdqtUyklQoPnXFHKvYUQSk+Wh8z6Tqenc2RzIHaZe5I/XJL65
	TiI+GbGW+tbDOpVi+9ZHyTRkWrA3hVgylojvBHhDiz4WQuFhfgAz9c/3QmwdjyBz
	nvKY7ujO1bsAk791r0f5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766395433; x=
	1766481833; bh=uRBVWAiaGAON24PWb1hMShWdsmQROohqUGwoUEzvwLY=; b=x
	t2cddAH4qRPXfdQE2o+LwvLYLa6Py9fA2IBAchW/y1nHg7yPr3PiQ2s5faK9Nh8H
	UqcNC3D0mAIW5eF0KCQimRakOcJjH/xzMth1m9Fy2vCRATeZ5nzSLPA8AaXRnKtz
	KJOnAZDic0QZcOE9FxFnK0jAQN+I9Ru4SOPixYt8e/4ngZNmVPBlG7978p29ZLaT
	5UW2psbSgRL1gxkjIAp5sjW/5WFoCiWEn6HC/z0CZMPSpxMpuj+etiZlTkEkZpHn
	79CMuJ2OQH/rJG14Rq66FuHMEOXkm19NLm4j5EpdmrEYH4M/7zzVclsK33lbCJK6
	bivyVgCz/aZJPrfl3BDsg==
X-ME-Sender: <xms:KQ5Jacg8aC1GxlNHYvmZBJIgeKb-oFygb_uuH_uRuLJmSs0guwJDvQ>
    <xme:KQ5Jaf1k7E97KKm3MQ_vwub8dArDd0dUtMHCsAvRfgxh6ZCQgv7IOkQSSHkuRk9bQ
    bu7tESIIyvWUow-N5Q_R2ylDkFCbBNAd3Bpq0NziVKGGE0_aaRfNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegstggrihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomh
    grshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    lhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KQ5JaSLESPWrfrhCk1HO_pvBy9KTFt3lYSPhoOlS6UKd1hkBOAl2gQ>
    <xmx:KQ5JaVlcIGpGOfBG275BrApgMuVYv6sbCtuBBvOrA3WTSdhRmqRmJw>
    <xmx:KQ5JaWNbthrAcU_WSRhwh8TnQQhzGV91_GqYBuVlBDcjjEAxrYCyUQ>
    <xmx:KQ5Jab3BMGpsV_eqWpeHrMmaZ3eKlTeWHgv1LUFStodo8BD4tl1Qkg>
    <xmx:KQ5JaXMn21-0Jk7em704ha_GFUJ9ssZ0oN2ab5PMIsWSY7f0JgmDW8vH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76F62C40054; Mon, 22 Dec 2025 04:23:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApM8UPHRU2I-
Date: Mon, 22 Dec 2025 10:23:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Brian Cain" <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5726fefe-4608-42d9-9761-595bae50bc0a@app.fastmail.com>
In-Reply-To: <20251222-uapi-hexagon-v1-1-192bf7d9d702@linutronix.de>
References: <20251222-uapi-hexagon-v1-1-192bf7d9d702@linutronix.de>
Subject: Re: [PATCH] hexagon: uapi: Fix structure alignment attribute
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 08:40, Thomas Wei=C3=9Fschuh wrote:
> __aligned() is a kernel macro, which is not available in UAPI headers.
>
> Use the compiler-provided alignment attribute directly.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
