Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91A20B20
	for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116791; cv=none; b=F/ljRVQ6ypIaE6CUz+yGjL33g9S3fFTe9SmtMHZRtLRGjxtJB3aE4fhDK3ZksBhhX9WWFlxvUatumKNe58EUU+BcuxO1BQhv4leebWnIs5HzTlZqj2hthoE3eCZPXxg7mPFZGjsfz97CmQfLyIaZRcsyUJp4eWLULrdNFNWZSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116791; c=relaxed/simple;
	bh=UwkZsnmFTogapUcvQLNdDygak09Kfc+DA1y61X4GWs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9Os62YnI/Q1VfIJK7mIRaggD604rz6KQB3P9+D1BjF0IlUEY8kdj1eoic5P2UAoQKmE1tO53Kza26+/mR0+2Cg7g2SEcoE1Hc0lAK7IA9b+SLYKsUwECW099whJ//93AbJrHo/1x/mB0qiAlrLckHdFuhUNeh1M1g12cbodmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EiVoqPTV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EiVoqPTV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso3999578a12.1
        for <linux-hexagon@vger.kernel.org>; Mon, 19 Aug 2024 18:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724116787; x=1724721587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=EiVoqPTV/e/MrqFuN37DXpcQCdbzcyHoJx7Ph+eaBLbWBnVfKZWJQTQaz+JWi9IQSE
         2IPOWu1d/Of/Uyd0dhP0zJmZ7bzPIvaYUVbl2Cxy+DdbalG5xMlhsvK+tTp/cxzlV8lT
         6erla7e7yvs/xAN8x/kNoGp3O7HGZWSA7bmvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116787; x=1724721587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=F42JgJwZyEBRGIwOc5YCULYnwSQlf+gaVLrPoKFOuGvktpPmPXfv1vAk3LoUu8874e
         CtQwvr9ANwaCD1B/83LGyXp3OEe9GqkmqAaju23c4u8f0qncBPWKn34wMvVEdlkbQhCo
         dBLA6WywQMZu/OGPd+mMjwik+3Rl/f3EjAPVlvXTsnZRAq9KFquE1rNRstQPnKMb4Jk3
         HqmpbdC8A3qlczXGybTjKMMrLX4IOzGNfF6zX0jqk8Vu/EY3fiWBcdI6UzRnTeVB1ApF
         OlPg4jcjc9iEzzpCkNVzlH3zzVWGUNVXUtPe7yh9yWeBpN0hAa2ChQ8NE9ngd4QszzD/
         Q5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfWNCnkzoTonsl0Bu5wCOWbLSvyxPUya71JV/DN/HxxCThmikKoKpYWK/vVezv2xFVCeqDhcW7o9IerQkjBSLSXLYbEGDsqjB95lcNZA==
X-Gm-Message-State: AOJu0YzvGxXJoDzL7kERPqSsBihhPE2xTdeY45oPWgzj4Z5RdPQgrTFZ
	xPXVxZwlEqyzKSbWiSiZMMY138RxShZnQxcpwPYy3LwOMr+lboeepSkU8E7BuRaAwG3pGQLkgbE
	6genvoQ==
X-Google-Smtp-Source: AGHT+IEyokn4H1ZhPqMCp4Vrdon33u7gnfBcJ5H0cFY+KLEVcetTfpBZhiY0ycJFumZSfxLKJoZgFA==
X-Received: by 2002:a17:907:3daa:b0:a7a:9d1e:3b25 with SMTP id a640c23a62f3a-a8647a0d1ccmr43204966b.30.1724116786660;
        Mon, 19 Aug 2024 18:19:46 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383949e45sm702351666b.145.2024.08.19.18.19.46
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:19:46 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so4158791a12.0
        for <linux-hexagon@vger.kernel.org>; Mon, 19 Aug 2024 18:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOIqnFBwn9jbyQRuo6LH3XNAq7zDHQK4+A12ougb04OEdyeqYXrFfnWzKWWJ3VTfGy5+1KAAfyXqaOpSiuDXFXuuERoF75Wsqr+uoWyw==
X-Received: by 2002:a05:6402:1d50:b0:5b8:f69b:65e8 with SMTP id
 4fb4d7f45d1cf-5bf0cfbca19mr536978a12.0.1724116301657; Mon, 19 Aug 2024
 18:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 18:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 18:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > I forgot to actually attach that "this". Here it is. For real, this time.
>
> Thanks.  Do you think your one-liner remains desirable with this fix in
> place?

That patch actually removes the whole 'legacy_special_mapping_vmops'
that my one-liner then removed the '.close' field from, so no - my
one-liner just becomes a non-issue.

NOTE! That patch of mine *will* conflict with Michael's patch series,
since my patch to remove legacy_special_mapping_vmops was done on top
of my current -git tree. But it should be an obvious conflict, in that
it just means that the addition of .close never happens.

               Linus
