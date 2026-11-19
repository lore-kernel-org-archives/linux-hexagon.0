Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067358;
	b=ai2aAMGEwV6vqJn40sJg2H7rLiyYKPV+iZJ22LPppyviqXY0fGYv2PoJfjGGftMUXCx0
	 jn49Tgy1KUnlb8mgh2NyppGqFDDE5RkoQRL0h9zmIvOL1lYHdahj3E8ikNZ1vWwyHBTap
	 cW+KdbY4xI/n89xAyNSSTbNiRLtrVdtW0t+tG6XmbBA9fbgr1d0S8+VWUUyQf1vqrWacF
	 eoUd8fGPSi6obtiQCFEAI9N6PojISsD/PBSxVcUrzUbKdbyMJalA/bavK8qwkPPoL+DP3
	 vC6xnDM3FYeReyQmbjzgTmZxIL54CMkbBbJ+GAIm7zAz9wsWpYx4olVP27XSJYO54dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=g3p7m7TkH/7KFsHJqKL1wxqRtKVLah1m/6dsx1ky3KI=;
	b=2APsolJ3Cb9DtUQCu+s44LyUUaSN7PGVZbOlfJxN9W6iGNLFcSjU3XMpg2yiImtQZyHF
	 RvnjbAW2nb7XSieoo7DglJfzBVGVoT3NDzvZZ/JyUF6YmqYZ1uawcSHdVdk+XvZ/WggsF
	 l1GH8ykb+0iwLhpkbOQjA9Z0wdkyad/AbFJPtA385pfOgfIppCILN0hOKl4DBn/OyesgR
	 gOxqn8WTT31V4T/uH+3lQZsWVkmfTFgxh43StjWa35Byn0TJA7gjMekB3bZN6I7/93glG
	 0G1GSVZVIa+N4g7sn0Deb4+quPi+nTCezf+l5lrKwD/GwgwGGBvCPv2aZ/pg0c9Um6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LnlqCPWE;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9275606A33B
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 05:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9275606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LnlqCPWE
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1149466b3a.0
        for <linux-hexagon@vger.kernel.org>; Wed, 18 Nov 2026 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067356; x=1795672156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3p7m7TkH/7KFsHJqKL1wxqRtKVLah1m/6dsx1ky3KI=;
        b=LnlqCPWEYxuXOZZUgpDQvd/HagWNYsMeoWLs1kuKinCBn8sjGzBL/9nWBAlZQw9yER
         sI3FEOrl9SBOpqrYVU7CzTwEmjA/Ae8ApsuLxcalxBGu9/aVeQ5TWEoKoz7dlownJiyK
         GkmxM1iI992KpFT69dGRBHK/TxCrlJrHXHwa7WRqv6PDswbWeA0qdtLwCpjoZPjrFR19
         vjQeWKaKtt4QMO96tOlw6KyS5vD3EqweqOuLvwBz1Y04S8a4YVDMrbgsmyS4yoSpNPUN
         JtZwKVwiok9tejr8aWv68tKXe8A+bVWT4TnmSu9woqgvWzfmlPXsjAxyJbjebsUBm41R
         yhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067356; x=1795672156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3p7m7TkH/7KFsHJqKL1wxqRtKVLah1m/6dsx1ky3KI=;
        b=YW6KCE0VcSk9NOSdK+PcKK2LNZleDjskzTzL1q0FLCEGJDRv0y5Kbp9bMubKo8pCES
         KffulUPLvp16e4DhNIQNztaGAkg04aGHDjfBc/yI9x8VLgnwJQF1PsXvniJzz4WeR3Qs
         KnUP4Kf4yYPqscEAMx6onYRdqsuKPwQOKX0wufRY9//C9PdVPGjSRgYOWoh6Nmd2P7IB
         Euho2rgYXumicK/XE0p+91XsYLhrxv8ACzElthbKTDHvm3if9ckLIRg1Q0ENqx5PqfwE
         FaGmwqHePdeAld48kylyj7nc490zI4a40WHM160vpE4dcj8Vx7Ev+mnySYQm7p4E5x6E
         KNow==
X-Gm-Message-State: APuU4Z/8a5LFolFrZL7nIg6TCFzgJHYMoK4rnq6rtreekMx7IrTzn85m
	t8gaDz4muVR6QEpP7ElSHmS+a8f2hUHsDFeqasmt3+FZaxldtg2IuR93
X-Gm-Gg: AYBFou06NYSKUwBNqyO+RFfqfskKBYCxzVZiLencJDt/5UDqoMrUyKNvVbNhIWgXAya
	Quy2lDs4prZk3SxsXwIwJvtAWDr19lF3ZpYLJx4L4J048TIB689PiBnFmXLEiqkIpaklb+qVr9Q
	RDqxRpDNgb502IsRELX4VRvFJrgXkavkoF04NOh9TSKgppiU2QzdBMqlQz4Jz7GfgmqQ5D3PWmC
	+keW1VvzduV/2H4v95TWOYd23UMarW5erEvbv+/x5XNlg6uQy2UC7MKAhGM9CdMhMi/cLsH+4xV
	LZDY2VauBcaP3DYsHVbB6leqlxzVyoOC2A+D64tWnJEeM9zaRkts/brv42CHEV4oxJdJCqjH4Ak
	PQR+aMrW3rozt7EYWo6YLzDIMinL5U131w5iGYP8s6xmaYQ7DuUNPVZJvbsLcujYWjsgELyJbCA
	HSy/65Ml9alrr9S/YTl+Ka6ilmW+MFAtjU3pcgB7F4zNnePxbN7/qCxUv2qrNtvdU/x+KisAQmW
	NQbUeJNLYa/XfH0t6sB8tpPZqlcHJ4UxC5oEmG5NkXvO9ZAoPGORC48LvQc5O5AMk1PmE5SPY36
	6gW8wLb+Q9Y02FmWNGDrPv0RujZNRsl6XYEoseuOySXpaVks1IsMefg=
X-Received: by 2002:a05:6a00:2888:b0:89f:db59:193c with SMTP id d2e1a72fcca58-8c5d2a738f0mr4157796b3a.9.1795067356199;
        Wed, 18 Nov 2026 21:49:16 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cac8fe3csm2200984b3a.21.2026.11.18.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:49:15 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: hexagon: allmodconfig does not link with LLVM 17 and 18
Date: Thu, 19 Nov 2026 13:49:08 +0800
Message-Id: <20261119054908.2988120-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Brian,

hexagon allmodconfig does not link with LLVM 17 and 18, on mainline
and on stable. Your hexagon-qemu-virt branch has the fix, 09df35bd9d9f
("hexagon: constant-extend head.S calls to out-of-file symbols");
could it go to hexagon-fixes, with Cc: stable?

With CONFIG_WERROR=n, LLVM 17.0.1 (the minimum the kernel supports)
and 18.1.8 fail with:

  ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):
  (.init.text+0xd4): relocation R_HEX_B22_PCREL out of range: 2242552
  is not in [-2097152, 2097151]; references '__vmnewmap'

and the same for the second call to __vmnewmap and for the calls to
__vmsetvec and memset. I see it on v7.4-rc1, next-20261113,
hexagon-fixes (0304683b4c43) and v7.3.4; v6.18.63 (LTS) fails with
LLVM 17.0.1 only. With LLVM 19.1.7 to 23.1.3, v7.4-rc1 links.

The calls in stext go from .init.text to .text, across the rest of
.init.text and the per-CPU data. On v7.4-rc1 with LLVM 17.0.1 that is
2.14 MiB; without CONFIG_LOCK_STAT, whose per-CPU data lies in
between, it is 0.76 MiB. ld.lld before 19.1.5 checks R_HEX_B22_PCREL
against 2 MiB instead of 8 MiB, which llvm-project 64e3466fd09e fixed.

09df35bd9d9f does not apply to the trees above: its context has the
"r2 = #VM_TLB_INVALIDATE_TRUE" lines of your series. With its five
changes made by hand:

- allmodconfig links with LLVM 17.0.1 and 18.1.8 on all five trees,
  and allyesconfig of v7.4-rc1 with LLVM 18.1.8, which failed too;
- where v7.4-rc1 linked before (defconfig with LLVM 17.0.1 to 23.1.3,
  allmodconfig with LLVM 19.1.7 to 23.1.3), vmlinux differs only in
  the code of stext, in the address of one local label and in the
  build ID.

Those trees do not boot in QEMU, so I boot-tested your branch
(dc370baa041d, v7.3-rc1 plus 24 patches), with 3 MiB of test-only
padding at the end of head.S to make the extended calls span over
3 MiB: qemu_defconfig built with LLVM 17.0.1 and 23.1.3 boots to a
shell on a buildroot root filesystem under qualcomm/qemu hex-next with
-M virt,hvm=on. I have no hexagon hardware.

Rebased onto hexagon-fixes, 09df35bd9d9f applies to v7.3.4 and
v6.18.63 unchanged; I can send the rebased patch if that is easier.
If it helps:

Tested-by: Tzu-Ching Yang <shingekinocore@gmail.com>

Nathan, once the fix is merged, the ClangBuiltLinux CI could build
hexagon allmodconfig with LLVM 17 and 18 again (disabled in
continuous-integration2 d9d773a8859c).

Thanks,
Tzu-Ching
