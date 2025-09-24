Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD953128AD
	for <linux-hexagon@vger.kernel.org>; Wed, 24 Sep 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730690; cv=none; b=HU+L0/6vn30wy6cKgIzmjWMn9l05UXpCHtmsfbqihB3jtfy5WOUIkrxH9lB5aJs7ylX62CXGpg9gox+kH+K9uc1Eyq83GEb1Qe6QiI6LAjoCYmsZ6zVV1aYbCyUMplTlqS2FJF9g3GUYqQlJ34fbPjreQM2GBcUMVODb/n0sAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730690; c=relaxed/simple;
	bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYpCZTZfLbD8sLOXzm8Uo1iJVWNSMKWqvXEk/VXJCCPDOLJsbizriBZ+36FJJM9EVZYLz9h0DET3B2nm4s49z+V48o3toYI09efpDYFvkwGFo/tqWGuUBbHWe6/veUMkTqyFJyomoRJ6yq9l+tcnkFcoaraPUnt86ID9CnvXyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ9fR/G/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ9fR/G/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b61161dd37so57591cf.3
        for <linux-hexagon@vger.kernel.org>; Wed, 24 Sep 2025 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758730685; x=1759335485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=jJ9fR/G/uQOoGU1zjzeq+kEGJH0FGPF6hyv+BRd11txZaP6jykJx7KYV+Fy89/hm3r
         Fj1jHTTr1k3gSZ9YbnsYf7t/+Y1cgcUQRaozim9bYqDxSSoV25zr5djoCo2k+XVY+9XH
         hZwrqWm/lkHBVgotX1/VMNfSLp5gX19VCA2QcSKMUDXlmxsoFrDA/aUnalMiOUk6S4Dm
         ApxpBGputpqRfa7MY3pOnEuQUef0R7OKBgerb0vkMv3dzWiW0+dXhhizmvnjoU/shLfI
         pMehbr68Tb60E0EQMTVNp25KF0WY4uOSvx5h0SUZ0kqikDM0hjKYe9piKoNpkOCmD6s4
         fVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730685; x=1759335485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=PNa6OyHKTzdtsx++rcN567dfz/TDDq1pkz7z/PhymEUNtQpPTCXKIDUee9TNERoPbT
         NiD5GIr8blC5B8HhOu3Fh/UP2s90IqA5om+TMXBbUlQSS8YLutouqjDY+2DdLnx0VPlg
         te0qOY6JSCNG9eM869hcX+LE1rsrbhiLLhkA9BWP5a/QGfiyJLbi9YAUnzliyqxH4N5O
         zZRdXzqI2CaBB0m/kfUb/LQB4dN8Y0TqZaS0WwFP3a+kqLjeW2BnfzBh4hGLpo1JEaGK
         W3V0aq+r9Ovb5zyo7GtDj9k08BcwAWGWCyzSCKnfo3rwopfoFk4AiSWaQfPtLElvNN+p
         kglw==
X-Forwarded-Encrypted: i=1; AJvYcCUL6gNxzyqYHXOYVU6inNtpHXE5Epj+RIeWwJG7zV6oXMFz1DaNm/MoTpRN1X+bfx87inOhucigS1w/Jpa6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NwSXf1C/TE2f5TEe9eNuuaQ0En69/ZL/h4rW08XRagIpmZ4U
	NA5N0hqZwCt3uPvqE75+9O1LBA/R6oHW4E5gNXBhuoHNgI2D+QM2ZYS90+fnzIe9KL+NhQNJtj2
	mNYQswyX8gcFsVKaH5a6046qnvbitMZ0=
X-Gm-Gg: ASbGncvPnm0PPMwflo7ghlE9Y1LedUHL8X7Bq1Gz2b/NpFgFEPaOUwrWfk0D/tKELqS
	QsqSCGX0HXgkx07MSw1bIY5nf1epmt0oPFySRIDf3i6z85QT1NZO1G/mEW5AL/Fayc38GWobTZ6
	SKXmKyzUqvA8f82LPjjKdmc8EoJ8wlbfZRHn7RMH7rifdZpkTPEez3X4JnPHOhRPh7kOTSof2Sz
	Dw8919bum7m9tUSmdlMyDu/lRPiZL3pDtWfEw+Z
X-Google-Smtp-Source: AGHT+IHrjx0XfB3NQHdqBt66Ox1dwY4oj3I0wMxztSwqqFAAkQnhEkK0QBLdnresO+RuCvDJitimjmBRn2YZHsgZxpk=
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id
 d75a77b69052e-4da473535b8mr6186491cf.16.1758730685377; Wed, 24 Sep 2025
 09:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
In-Reply-To: <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
From: Alexander Patrakov <patrakov@gmail.com>
Date: Thu, 25 Sep 2025 00:17:39 +0800
X-Gm-Features: AS18NWB-xeGoRDKYPj3kUYXUnKXLhFMFvvc0QyoLpOeKcP1DsD-enKeBhlulfsI
Message-ID: <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:22=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 13/09/2025 =C3=A0 02:37, Askar Safin a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > Intro
> > =3D=3D=3D=3D
> > This patchset removes classic initrd (initial RAM disk) support,
> > which was deprecated in 2020.
> > Initramfs still stays, and RAM disk itself (brd) still stays, too.
> > init/do_mounts* and init/*initramfs* are listed in VFS entry in
> > MAINTAINERS, so I think this patchset should go through VFS tree.
> > This patchset touchs every subdirectory in arch/, so I tested it
> > on 8 (!!!) archs in Qemu (see details below).
> > Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_IN=
ITRAMFS
> > and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
> > CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
> > If you still use initrd, see below for workaround.
>
> Apologise if my question looks stupid, but I'm using QEMU for various
> tests, and the way QEMU is started is something like:
>
> qemu-system-ppc -kernel ./vmlinux -cpu g4 -M mac99 -initrd
> ./qemu/rootfs.cpio.gz
>
> I was therefore expecting (and fearing) it to fail with your series
> applied, but surprisingly it still works.
>
> Therefore is it really initrd you are removing or just some corner case
> ? If it is really initrd, then how does QEMU still work with that
> -initrd parameter ?

The QEMU -initrd parameter is a misnomer. It can be used to pass an
initrd or an initramfs, and the kernel automatically figures out what
it is. What you are passing is an initramfs (a gzipped cpio archive
with all the files), which is a modern and supported use case.

--=20
Alexander Patrakov
