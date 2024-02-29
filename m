Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AA7E599
	for <linux-hexagon@vger.kernel.org>; Thu, 29 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213690; cv=none; b=LIf6o+1E0RrCrbTp9WL1Otb2j3PtnYJA4c0BfxUw1bL5UHAMha+46fgb0rdpv6JtG/WpzHYmqsOl8YaZVySVfO67h7g5Qv+REFzZuZyjuOoHHkPJphrQ3IGDXpboTXzOa7BnKUl0o4tCbxOx/x3E19n9oe9EzuiW925RC0fthS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213690; c=relaxed/simple;
	bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFBjSXwau+YzBC7wdM8I5SSe+FNEWyy5PxUpFH0tc+ne05J6a5gh+mtVsRXGoW5B+2Wkv75wxy4EdBhGnfMKgh+b8ZbvbmtEp3/9PBO1FvkDe4wX66QdQSqdOqEsjnrSogo3bVDEU7/iQK3bd8StOcda7JkrX1fMNtofzH4x+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYTHdjbe; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYTHdjbe"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso712582276.1
        for <linux-hexagon@vger.kernel.org>; Thu, 29 Feb 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213687; x=1709818487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=rYTHdjbepJHMdVjx9Imtk329wSoXnJZBxYtV726m28GV/V7gkGQXPfFJS2NlI0S+Z3
         pXj8RmkMOPs3Jb8OVqphW3Napgbwm1MIUNERMqYj4NC7ltvi8pWlz+H7gayZ6OINuFIs
         2OVx+oS+NV3eE2ZEX02/Rm9ABRCLur7+SmPKQ9hKv4p7d2wFX/CJXyoayu9c+vgIBTzW
         8wK5fPlhwVYHyYN2E86WCIwXywoAeodSrA5Fseo5fERoN2K9XEyGZOQw5KPl57WMELqa
         EfxraAKLsT0oNEysbw6hjhZJblor543ZwdklXGAAb1Tl4oYZgENGAgeCEVQK+lmfcI54
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213687; x=1709818487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=l9A/x/v7uVkCkMWf05UMPLKqGiVI71T357o+SqYY4o9sCO44/VJJqSDcgnlrxzk9ro
         UW1d0bvrpWN0Q2KAijuztrbwpb+pf9t4KEi1J+huWyIr6xPDw6M9ZLun+U6cw4HsqMYz
         PhTe0fEFQc7scYCvh/prpIxZzhITcZ3b1qW5mBdXfqfRhtFm95hHSbS12R6tQlInsB53
         z1I8qFK7/AztWOLqWzwlRYi427MusT+EUW2zcCH0EdYFMc8118sdSezbVTSAEFTMKb59
         equx4MHpF7iTCT3A+q3l8WMUkYgJWSziiCw1v94YcSu/mXIi12QSS4AZ42yFSR5f0UAg
         gKRg==
X-Forwarded-Encrypted: i=1; AJvYcCW81sNPFOSMB246o8NspRwQ1D6HbfyIuM9kFNzEzg8+ETnwycPdoXqlUajt+3nhO7WBk20PsOm6Dsg99VuCcuhGC0JbHz8Q5QvOr1OCuA==
X-Gm-Message-State: AOJu0YywL84EEZ/1dGFG6RBERN5LUyGS8zo6MIg9dUG3TU6DNSPfYcuq
	W/6FGDL1yB3VL0nJvRBwMVhvZsGP90GksoL6c/AmUUvbG2zQEczixpjqTlmakGyTbMW1DDATHVF
	ujSawAsf67RGXrvpRdSWrbPq++33lcnDpa107xw==
X-Google-Smtp-Source: AGHT+IERWkObLg20g5CkQl+tvX5B3XTQSnYQFzXQbIMveAsaz3h9XahcBzBqENPTvOu/rO9KsYEoYLjXlY8xXBwHNlw=
X-Received: by 2002:a25:a347:0:b0:dcf:b5ba:1403 with SMTP id
 d65-20020a25a347000000b00dcfb5ba1403mr2165256ybi.6.1709213686916; Thu, 29 Feb
 2024 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055740.2579-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055740.2579-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:34:35 +0100
Message-ID: <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlin=
es")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

My bug, obviously. :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I thought this was already applied with the other fixes, but maybe it
was missed?

Yours,
Linus Walleij
