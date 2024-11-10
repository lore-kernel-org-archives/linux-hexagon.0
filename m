Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E931BC2A
	for <linux-hexagon@vger.kernel.org>; Sun, 10 Nov 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254660; cv=none; b=Jp2Lnz5mT6eu/El1b41ql4gaNTVLy3L+3tJFS2f4tjKKcBKqFOc0ZBAuM1Lsc/pceWNKSHZ8bIU9g1j0XJ6eCAjtfmWOrUCXrO+VuMnMZaHPx67+odCclQ3uZGDc5fOcnvrKM1b8/L19swLI6jQqQKnEpGim6SOOI0aYi8HHqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254660; c=relaxed/simple;
	bh=nHRE6WZmDmxm6cz61isRvnuji8FzBy90v8oGifTA5xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O27NeMIdw5KdDv6uPxtGcb6x17CwmTPrC9xz8BBWbAC3Fq0rGcWc2J5NbxjKazqAL9w+NeXkUDk3RxxTrewT5UID/rqsY+KBCj/nFnu0QhSR/avnt7tf2n2egz6OhHKIPiDY4tNOQQv7wZli+t4ebZDaevR06ZAam3C5TUGrRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA4FEtr/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA4FEtr/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea1407e978so33255507b3.1
        for <linux-hexagon@vger.kernel.org>; Sun, 10 Nov 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731254657; x=1731859457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CNLnBAFHpBPWxzZ1Zk0tYkCjdbAVe0IGKVgCD+DJas=;
        b=SA4FEtr/hzopnkH7U967oNgO5QdWCwEzBdNTjM7HdX2oEE2c0qSSEzfQ9osztVD+6E
         ZFged5bpCgktz9KPnP9wDA/wOwcemRnhiVPK1U0AQVPN3WnedZNC83WcHQvuLd9Aukke
         LbiS5Thpo0GlLCCQvLT1Gw3tdkBhsHM8ylbu5z8BH2rRqMm/on9VCtxGiCZGRrdQvx1J
         NE1x5NRJVXZmG0AeQ3A6c4D2VUTQYXYE/MKrC5rKl3ZBT1g/TTiCrCWFO9uEYszeqUio
         vn8bBs6AabFkWDhSgqkFWkV5FmH+A99kjr4jet3xXvo+gt30AmxHdz8GzDZdng2AK1RC
         4C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254657; x=1731859457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CNLnBAFHpBPWxzZ1Zk0tYkCjdbAVe0IGKVgCD+DJas=;
        b=Ye4oVXoCbkxNn1CA9ZVPX2+AdWe3lIHz5btY6OCVCeuspnZSRrIC6WLL1br0lqZuux
         YBzXQlRec5oEhtIUy6t1rJRvfA67keICsWM2eDPac9JJY95e/YscBHUnycWkFd19v1FE
         F1hFufUHb7e3H/KH1ThXbvehClQOHheaI2i1epIW1e0NPfHjWywPRREgvcAUqKIB+/DH
         tnLJqwT7kPlJ6LAE2Tmntq6uMiWhcsGc+eS7eHfNewmntsttCVINpuxMZMCJaVND39yi
         3jVl/gYS29kNYPoZmklLhvTzWMBdQnezwN3Q/RYyr5XNscMhdyBKnYunuLTDaaZdmVlZ
         Nzag==
X-Forwarded-Encrypted: i=1; AJvYcCWvk2l+ga7BbPDtRLuTgpSRlRE3Z+aqKz4FleJTo6wW1cU+Z341CWSk90BdXEqzpFTNqxLIMTusK/icAh28@vger.kernel.org
X-Gm-Message-State: AOJu0YykxvqCnDU59x/htn8sAVdlJqdmMPzcjJ2TBz2U8JI1fHSo1ey7
	vLI3+4ZBgdLX3BIp/Eu2MYVhh4Dg7ZfitROG7mnp/a5LwBYHBfd8FCh89Mah7POhTRrzveoc+eF
	4P5gEwdePHSB9me8j4sB0NkXnbgzQMm1U8WGq
X-Google-Smtp-Source: AGHT+IHYOc+K90gPkGm8yETeFrM7lrTDeWTKOwf1O8X62M9lupAJjFOOS+Dl9aJoc/4r3l5hr7bVY/C4FysxiRvsleM=
X-Received: by 2002:a05:690c:3501:b0:6dd:d0fa:159e with SMTP id
 00721157ae682-6eaddf8e3b9mr101861267b3.30.1731254657264; Sun, 10 Nov 2024
 08:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411091538.PGSTqUBi-lkp@intel.com>
In-Reply-To: <202411091538.PGSTqUBi-lkp@intel.com>
From: Willem de Bruijn <willemb@google.com>
Date: Sun, 10 Nov 2024 11:03:40 -0500
Message-ID: <CA+FuTScwvZDxX6OVAnde+hBCKp5P5UF74jFAL-6HEQ3v1Wg_sA@mail.gmail.com>
Subject: Re: net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer
 as NULL pointer
To: kernel test robot <lkp@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Guillaume Nault <gnault@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Howells <dhowells@redhat.com>, linux-hexagon@vger.kernel.org, bcain@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 3:00=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   da4373fbcf006deda90e5e6a87c499e0ff747572
> commit: 223f55196bbdb182a9b8de6108a0834b5e5e832e inet_diag: allow concurr=
ent operations
> date:   10 months ago
> config: hexagon-randconfig-r112-20241109 (https://download.01.org/0day-ci=
/archive/20241109/202411091538.PGSTqUBi-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce: (https://download.01.org/0day-ci/archive/20241109/202411091538=
.PGSTqUBi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as N=
ULL pointer
>
> vim +1511 net/ipv4/inet_diag.c
>
>   1503
>   1504  int inet_diag_register(const struct inet_diag_handler *h)
>   1505  {
>   1506          const __u16 type =3D h->idiag_type;
>   1507
>   1508          if (type >=3D IPPROTO_MAX)
>   1509                  return -EINVAL;
>   1510
> > 1511          return !cmpxchg((const struct inet_diag_handler **)&inet_=
diag_table[type],
>   1512                          NULL, h) ? 0 : -EEXIST;
>   1513  }
>   1514  EXPORT_SYMBOL_GPL(inet_diag_register);
>   1515


The code is still present in latest net-next.

But this appears specific to the hexagon architecture. Specifically to
that initialization of __oldval to 0.

define arch_cmpxchg(ptr, old, new)                             \
({                                                              \
        __typeof__(ptr) __ptr =3D (ptr);                          \
        __typeof__(*(ptr)) __old =3D (old);                       \
        __typeof__(*(ptr)) __new =3D (new);                       \
        __typeof__(*(ptr)) __oldval =3D 0;                        \

While here *ptr is of type const struct inet_diag_handler *.

Another typeof as cast seems to fix it:

+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size=
)
        __typeof__(ptr) __ptr =3D (ptr);                          \
        __typeof__(*(ptr)) __old =3D (old);                       \
        __typeof__(*(ptr)) __new =3D (new);                       \
-       __typeof__(*(ptr)) __oldval =3D 0;                        \
+       __typeof__(*(ptr)) __oldval =3D (__typeof__(*(ptr))) 0;   \

Easily reproduced with

make LLVM=3D1 ARCH=3Dhexagon defconfig
make C=3D1 LLVM=3D1 ARCH=3Dhexagon net/ipv4/inet_diag.o
