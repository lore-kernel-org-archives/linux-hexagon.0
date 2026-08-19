Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C83CB551;
	Wed, 19 Aug 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164218; cv=none; b=UiVQqG+RHZc9jUolCFmIAtgLQCI/yTrMMLpD9Yc/pLz5SGqbj+fiT8tgSp4H0ib6Txh40aqHav3yavJJfWfJiZSGGU4JgVqy4N45YdzXfSFfHYlZxfybEMLKfZMe+YU7iLxI5LnJHgeOLLpL4Jt8bUpDx+eAPchwjEoPi9+wYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164218; c=relaxed/simple;
	bh=Yh5czg7XqOrKuSKdGs214u44mw7jx7akle+eYiEyb/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGvHY004oYKzp/lOlLB9YMcUHX3kumKxWIa/blSVQ4BYq9R0pp37Ttir2d5D11ZORcm/J4ODMVa6xatc0g9T0bgxaEuT28rS4dpYss6uOneCg0yrJDwdUd8sLAAEyjjS9VBapRwDUGadHZs1Ie+KMxpEVpdIEUpXK5Mcz7sMEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hhpZ7r6E; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hhpZ7r6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787164213;
	bh=Yh5czg7XqOrKuSKdGs214u44mw7jx7akle+eYiEyb/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhpZ7r6ENDtUfrDXpuuUf6TXQTBjpqXdezKCurJv9OkKE7Y3/SKOy/NY+gE6DQes/
	 2zmN6nzBso7jtNbnO637OyqPXb3EQG6lycbmY4u14RmlEDsyTBasfDRY+IvDlwvVsN
	 59T9TeKI50332E6ryVxqaT9VgN8fHrozPGA6enUU=
Date: Wed, 19 Aug 2026 20:30:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>, 
	Shuah Khan <shuah@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/nolibc: hexagon support
Message-ID: <944f4ad4-6473-4058-b0da-25f9ed45cfae@t-8ch.de>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
 <9b5eb6f7-3d30-45c9-a00c-58d28db4c442@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b5eb6f7-3d30-45c9-a00c-58d28db4c442@oss.qualcomm.com>

On 2026-08-19 09:18:08-0500, Brian Cain wrote:
> 
> On 8/19/2026 1:31 AM, Thomas Weißschuh wrote:
> > Add support for the hexagon architecture.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> 
> 
> Thanks, Thomas!  I've got similar nolibc patches in my tree that I have been
> sitting on - but I like yours better.

Out of curiosity, are you using the hexagon nolibc actively or was it
just for fun?

> Aside from the copy/paste error Willy identified, LGTM:
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

Thanks!
