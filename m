Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3314AD20
	for <linux-hexagon@vger.kernel.org>; Wed, 13 Nov 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516220; cv=none; b=S83WQL814Z9M4H2BZy41SBH2Lu2UZ0FHUKoW3SKMK525rufpDrlWzoAsbSCv8qWc74voN04i0g5LDCgOUDNy8yQGwtYZvSw2rpLO4VgOCI/h5VKRJuF5LzEDwGYIhuIgeMsPTS0111t9wR98QNDeOFgy1Ma2eOvzSOWyVaICLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516220; c=relaxed/simple;
	bh=IX6nwl8S1cSqdlF7c2ZuCCsJWl3Tq/Vv9oqWWKwj2sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuVwrDPXGKYBrmkl+1I6GlICwh/u8qySImUDuQ+dlTLCLXg6cUJO5Yb7NFgl3KP3yz/9DIIu0E7EVh335CNzeGvvDLZA/5GZbfkl5yPA48uwNDUAuiMDCc5CvrY+8tv88myT3wiUKlfRh/+zUizSQeNubJy7ayttJGHP+y20450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkVsZS6r; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkVsZS6r"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb47387ceso75327045ad.1
        for <linux-hexagon@vger.kernel.org>; Wed, 13 Nov 2024 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731516218; x=1732121018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgPHRZzhn/BgFJQ3GQ6/XKSU53FzjUunIQ5VJWFDlTQ=;
        b=kkVsZS6rHly7+8m5fNLuWXIGdvJqGEFDrvffeaxnKkr43JUgvvvqyCI1AWxRo4Gx4G
         O3tg27058n67U+pPd6QcWuDaZpnkoV7+bZ++SxVuYmIhDGQQI6vah6d8j/1FHvgF4BhC
         WVAWSF24YqRnBK/UbEBU1IittRxJLcU5M9Ne9FkxDB/YBfFzMCCB9GuehGtYD4s/pTdb
         gDZv97cJGfh7fBgwuK1hGeTp5cyGe7c2TmvBUB8t9q9yp1Y3Gu2N0pq5FMaMoBfUCQ5o
         YlVhtYA+SUPsGiCLdmyAp3RrWQmVNogeLLRg7C5wdkN1I5ySS9Chjv9BCWyd2Oioab+G
         iq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516218; x=1732121018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgPHRZzhn/BgFJQ3GQ6/XKSU53FzjUunIQ5VJWFDlTQ=;
        b=p6+Y1neOLwCYEL8JBZ6DfyIcOLsKnPnMtjKLqKijbeq2MrQs20pzZjFLZsTson1ku1
         C+GbCO3TLxbKtlKiNQq6JcOPa8AoSMqN6YfZSyy2NU140FYM6hVeuT2HxyGY0BwIKc3S
         s3aQGd99+IOXZ8NWI+ZcgvifouF7PUxNrZVc9OCOs/EokIFtNdW+gKjeKJXNxuO/J//6
         nv6NTZ2QVcHe+rTql5LLP3TT9SS2ItSHkUMpUwRHp8oB0DQddy2tYYYcJJEgvBKnXCTH
         vN6Fy+uKx+BEQIEm7G/sepbF1ho6pG/JxCYijOOb1FBgbgMDBrGN8s0XU9fGZHI4dMhN
         +jMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyAF2QScCTX3Pmx2euuWvTddi7NKD9/FFqub7regV9PnqPRs43bAuMZJzBhFMV5sYYcCalvVv8d1KMwubM@vger.kernel.org
X-Gm-Message-State: AOJu0Yytiy/Ygn6T5KByUH5Ig5LmGAGlb/4SalV2QPzTx4fZNjlU8CLQ
	OvF9aNddnZUBEJdcDQDKNZ7bx8xK4AmuNmx4D8LIMIzxQvlTbXzugTpkWC5f0OFckPKLZx/qlAK
	HX7sPg9u5LIdxB1jzlKrfP1sw27GsTCpN9uER
X-Google-Smtp-Source: AGHT+IE5R5UwXWzDg5H/9eKx/xgIt+u3w4Tu1ahz06jOHoM94pkRh28Cbaqfknle8kqnX49/ySumHHSYecZw5UFsvwU=
X-Received: by 2002:a17:902:f70a:b0:20c:7509:d948 with SMTP id
 d9443c01a7336-21183517852mr278644275ad.17.1731516218253; Wed, 13 Nov 2024
 08:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113041319.GA158543@thelio-3990X> <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
In-Reply-To: <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 13 Nov 2024 08:43:25 -0800
Message-ID: <CAKwvOdnWZZ9We85caDM7zQsrUeKhJ2v2xL8tJbjeVUEgv_vL9g@mail.gmail.com>
Subject: Re: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
To: Brian Cain <bcain@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	"linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Alexey Karyakin <akaryaki@quicinc.com>, 
	Sid Manning <sidneym@quicinc.com>, Sundeep Kushwaha <sundeepk@quicinc.com>, 
	Shankar Kalpathi Easwaran <seaswara@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:18=E2=80=AFAM Brian Cain <bcain@quicinc.com> wrot=
e:
>
> > -----Original Message-----
> > From: Nathan Chancellor <nathan@kernel.org>
> > Sent: Tuesday, November 12, 2024 10:13 PM
> > To: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org; llvm@lists.linux.dev
> > Subject: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL=
 out of
> > range)
> >
> > As an aside, do you folks working on Hexagon do any sort of validation
> > of the kernel and toolchain? I feel like I have run into a decent numbe=
r
> > of Hexagon-specific issues this year and I am curious if any of these
> > things have been caught by any testing that you might be doing.
>
> We don't do enough testing of the toolchain changes with regard to the ke=
rnel.  I think we have room to improve there.  I'd like to incorporate more=
 testing into our workflow for landing changes in upstream LLVM.
>

Build testing a few "blessed configs" would be a good place to start.
We spoke briefly a few weeks ago about upstreaming qemu system
support; that would allow us to start boot testing (though, we're
using buildroot to create small userspace images; we'd probably need
to look into hexagon support in buildroot then, too).  We're happy to
hop on a call to discuss some of these topics if you or the team have
questions.

Also, thanks Alexey for the quick fix to LLD!
--=20
Thanks,
~Nick Desaulniers
