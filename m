Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62D6FC5
	for <linux-hexagon@vger.kernel.org>; Wed, 17 Jul 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188950; cv=none; b=eX4/nXwxs9iSDu3y15XR++FC8sNu3bulli/8djbmCWeVokQD6a8h3rsOx7JKONa+e1p6/2uAPLf4uzmqHqM/+MPT1/s1LX8NT9vyowpp+QVs57fiDIRM9AHWps1jpIbdvg/QVT4STzuAkPI1dNi0n11vlNyVk+mcTa5kOApUBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188950; c=relaxed/simple;
	bh=+PBwcB9983LmNCN43zPYuSin1XxQnwumx190TVwsnxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE3V+2GXPyRh2s1B61o+TnBx6J1N/rDhmohD/AsOw9tp1YjmJyJk3mz84xq2gNl9akuzRma0dVWfUnCrEYYRT0IRREoPPqL41GeQ78sDqcYlXWEetUDYxMaT8hkdLUFcxfac1omzPbOigtzEBNrY93SASKUg2ZKjJ2DLy4BYhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EkyTkP8x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EkyTkP8x"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so698589a12.0
        for <linux-hexagon@vger.kernel.org>; Tue, 16 Jul 2024 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721188947; x=1721793747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=EkyTkP8xYeF/gAKH90P71Wb22dtCODRICCIhiC1usITZEh88IXpF8i/XMtQxsEA4SX
         be0poQcJfiz0R4dif9eiP42pj3SEu7JZB3t22yRKPgtZjHC758g4eMu486QTKEkEYsYW
         Aq4WaHNkMqSyFYVQRcnZveCB0fdI+/OM6M0Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721188947; x=1721793747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=tlpLHvqXrj6CcOFNpX3smIx9YpL0SPHOH5oE0uulsHWquSWEt3H1Ui09QAKOIttDYL
         l+ii12G//Nx3kXG3xY8Ryu+vhAKWQYjtHLhgStRWG1Vatd2JvIMSPneeFIYFd5e1vWOn
         wIr4m6I1Smds+UkYIXppO+WH1Q7SVB12WPmz+wL1FXh5Ee9u5RoNJ9Dm/3UY3WJWtBI6
         PY415jpEYEl+LUdofNgRj0/V6wKw5n5ppEWiJ5vIUdElZL+1VCmQEUo8tKg3F5xEWRp7
         zXvnzoXiLEs7oTb/03GFoVaTg0FfEkPAORpwcv8EA6MkHnLStMAJrcoawlXOqGa1pGDu
         dRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ayBA/OYRBVofeAUl54ejAzACvNsy2ethlE8LTjUvyLBS66Li4DozvrUZWkUWwj9XSOjBpR6xA7Dauop1di93cUulnCmjHM8KzYOLUw==
X-Gm-Message-State: AOJu0YyGajo0lTTONl9dRZbYA7itdclJb+rctG3gdIPvL/sOY0gt0t0Q
	zPZZtVgXiM5vSgeXrJPIC1HOTUyZiwBYonN3jnfs7F3fG+xmMPLKDP9pUaqEm5Swi548CFSlgpt
	LI7dl7w==
X-Google-Smtp-Source: AGHT+IGqvFSQLbFpagjmD0/CbdLPtbDnU/Il4saPj3PbISvqcBMQhS/klSQsFNlJ0OfjskxPCWpX9Q==
X-Received: by 2002:a50:8e4f:0:b0:57d:5442:a709 with SMTP id 4fb4d7f45d1cf-59f076a2869mr4162714a12.0.1721188946011;
        Tue, 16 Jul 2024 21:02:26 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f621b8sm6079318a12.85.2024.07.16.21.02.22
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so698122a12.0
        for <linux-hexagon@vger.kernel.org>; Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTG3cDs82hRdLFoDSQaKvjGzmvEXg4MsE6n/tXYi2R0/EahHG+OsBQwcbj7NnBZWBPia+5e+ZdAd/rl6WQJOPagvRy3IKA3iIXU6WdNg==
X-Received: by 2002:a50:8ad2:0:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-59f0c41dfa9mr3193440a12.15.1721188942100; Tue, 16 Jul 2024
 21:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
In-Reply-To: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:02:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Most of this is part of my ongoing work to clean up the system call
> tables. In this bit, all of the newer architectures are converted to
> use the machine readable syscall.tbl format instead in place of complex
> macros in include/uapi/asm-generic/unistd.h.

I haven't bisected things, but I think this code is seriously and
utterly broken.

When I do a

    make allmodconfig
    make -j199 > ../makes

on my arm64 machine, it keeps rebuilding pretty much the whole thing
every time - whether I have made any changes or not.

The second time it should be basically a no-op. Sure, a fairly slow
no-op, because 'make' will go through the motions and check all the
dependencies etc, but it shouldn't *build* anything.

But that's not at all what I see. It rebuilds pretty much the whole
tree (not quite everything, but at an estimate it rebuilds the
majority of files).

And the first things I see in the build log is

  SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_32.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_64.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_32.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_compat_32.h
  HDRINST usr/include/asm/unistd_64.h
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  ...

which is why I'm suspecting your changes without having actually
bisected the build time regression at all.

And yes, I checked - it does update the timestamps of those four
generated files: unistd_compat_32.h, unistd_32.h, syscall_table_64.h,
and syscall_table_32.h

Every time.

So I'm pretty sure it's on you, even if I didn't do the bisection.

This needs fixing, urgently. Because it turns a "small pull" into
always taking 5+ minutes for me. I didn't notice immediately, because
many of my core pulls I _expect_ to rebuild everything, but...

Btw, I don't see the same effect on x86-64, so this is purely an arm64
issue (well, and presumably any other architecture that uses
'syscall-y').

You might want to do a build like this:

    make allmodconfig
    make

twice, and then do

    find . -newer .config -name '*.h'

to find things where the build has generated header files with new
timestamps despite no changes.

There are other bad cases, but the syscall ones seem to be the ones
that cause problems.

I'm adding Masahiro to the participants, because of some of the other
files that *do* show up for me when I do the above thing:

On x86:
  arch/x86/boot/voffset.h
  arch/x86/boot/zoffset.h
  security/apparmor/net_names.h

On arm64 (ignoring the above and the syscall ones):
  include/generated/vdso-offsets.h

That 'find' also shows that the install headers thing does the same to
the ./usr/include/ directories, but the kernel build doesn't care
about those.

             Linus
