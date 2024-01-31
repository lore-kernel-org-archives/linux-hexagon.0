Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CD3E498
	for <linux-hexagon@vger.kernel.org>; Wed, 31 Jan 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686676; cv=none; b=tL0KG9Pt64UCQ4RQ9GqhjP0d9cnw8VGniNzuy7wGLeCRHABKmqLT1yqDONfjJp/dzUWxWpDb6KqD5odAvmvYP4YGuc3A6PrKb9ot8SU8UG+W5EdN/jmPLn/uByVtTDuuCQ8gReQfkK31vL+Dh0vmlo2qzWr21gAWoz0ibcyMmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686676; c=relaxed/simple;
	bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMk2VZGNDzzxwXhoEbxUc+/PxYl+Nc9RSePY/Kpyn1w+UxcWntIpeQlRsZl4qIW9SUlmVZclFkYBcpN1zX9UwxA3cLHdIib1JQZQGZSqmcCQLhP/DhwzAOHIHs3z29PszWNQw+AZYOs0B+rWQXbTjOoYTTOMsoqk7N8xJgN3kWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qugRA3lU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qugRA3lU"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff821b9acfso46316797b3.1
        for <linux-hexagon@vger.kernel.org>; Tue, 30 Jan 2024 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686672; x=1707291472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=qugRA3lUGE+4iv2RbCrW9rOiaw+w1w3TnSsPYDomTVfsIhBg2yT8hCDktaLzV3YGPN
         WBPsoZOl2KfuIr0rENOH+XOCCEeDvC3sZczUAKUMtG7ZqIdeEaKs1yFvO/WULHi4fXYc
         QXg/hYuy920fMaLiFZcR5MURBY0NKyO505nTAXQiC2yHNPMZ2aENuRnHDJlfmFVDwVJl
         7qt9yIFqWkVfGto8L5BeZSTJ3GlnL8D6EaEgkKMbzlDnoa/G03OPi52x9soysoVd0wst
         agXaaPO1fxdI4jS0s22srNBdAFPD1+vYng+hLso2Z0EQi5ud482G+YaHuHAD5CMh49p0
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686672; x=1707291472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=qJpWqjcovycSgI6qaQ3OlkoF3CZxme6JLaglYS5eTDa+TLtug/8456LMPZaZQpGN0M
         B+FmymiC4N6RQD7hXuMu2ZQfBOmtw0PbFBsW93IM0EKhgB+lIMW8J8eH85xJ2WMComPI
         fPYFqxwliuovcNa5unrHOdbsDBt5eL421r6fl2BU8FE42T0dndXiPG3o4PNewk3H5aLp
         piBfvT8orQDWL8r1jLbXXtihgXmAkKZVqQyjPWzDVp5EtodYQqSkyLHAKO+IjY2PNxhT
         /z/h1LsUkK7sdyI9lS5hiinugMMyho6bhQbEzR0DDo2ryzv70B+wECcNA7RPQcQeS4XK
         hECQ==
X-Gm-Message-State: AOJu0Yw7zpkxL6Iu03MKOwtCYZTsN5WJYVPvId9+WMi28pj7zwgI4ud0
	9pHZdFiRINN3mYP4rb+TFrkHafLEdJQYjBMK0LLkMCglT2Hwlada0Hnw2FBrEX4xkqKkbTqx7h9
	5z32dE0cSHWZfTBb1eN49xlr4yQ2zAsbtj/QKyg==
X-Google-Smtp-Source: AGHT+IHYpXRaWLqQlh0oX2pZAjMnT3Ad18mWcU8jYVwFB0aAGnyeiCdKxqpu+uBFZ0ub/5leFryzgJhdACbtZXLSvtQ=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr594058ywj.34.1706686672385; Tue, 30 Jan
 2024 23:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 08:37:40 +0100
Message-ID: <CACRpkdY6dS_sedemVk-fGzhsyT_B5dXAeFX-PO+GcvCrt9Je5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:25=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> This is a tiny fix to pfn_to_virt() for some platforms.
>
> The original implementaion of pfn_to_virt() takes PFN instead of PA as th=
e
> input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> is not right under most conditions, especially when there's an offset in
> __va.

Ooops that's right, I wonder why I got it wrong.
Arithmetic made it not regress :/
Thank you so much for fixing this Yan!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arnd: I think you can take most of them through the arch tree.

Yours,
Linus Walleij
