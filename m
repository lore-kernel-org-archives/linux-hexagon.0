Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19191DDA3D;
	Tue,  3 Dec 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264262; cv=none; b=oZ+Lz3OPmUYEagLtOIzRVCwlnVX9MWWfKzOaXBj5GO4Ib/okrUrrpy9ehahld4ISzi2oOvr2C8O3ZkG1nrAKI0gQEFs9PGcJcEVemK97yogJvY66GgaYMt9E6J7ESmhkUFUaa5YbeO/wZcZbtIC0bpmMcxUqhv3fFr1yjkBL6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264262; c=relaxed/simple;
	bh=83ZFVAL6rI26mNFtdBIhNwOZiIQYVo3JP+Cf9wzBjEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fURn8yyCaYI0UieY099xrlAEbHrUD97nMxPBU+tsbJSlQyGFXjOYmSyHsVCywFRiCq/tQxuPRd7ACn5w86nPRxDazRI0cSqAaTAhO+/1lGXrIGdz+wke6+3O4CdjA9hYToeSqWZBjw0CIqyfZ78XvxKz5Xwj0WNFDCktP01sVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIBEiE8k; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIBEiE8k"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b673cb2708so405378585a.2;
        Tue, 03 Dec 2024 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264260; x=1733869060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zx6S/CQb0tqcpFEmYEJYTrZg4ruix/9Kcwctkpw9FSA=;
        b=HIBEiE8kiBeyqXpNMk+fJC4L0tzsFeK+znuCtdFWH/U8zPrSGGr5DdfmAdlR0siJs/
         cM9L6M8F3HfgH+XUfoaVYQ0du3IL56dxef4fDK/8Id5YkKFg5CNnnqPEbOr0JFRlbFX4
         uZA0foA2tSGTQJZQYLeQ1HtjqTKsnzl3ZqFzWN5jDPV9W4C6v/BanHB2rZPZHp34EMdJ
         lOQerFYafbJk02R6HQvfQBvNh0abrBfFiegpAibOw1t0xAc2CVRC7mPiF/aaV5Oe/QqQ
         NMGogwN91b9xcrH0YBQYFWJ/hciJj7Men9s/NfQzq/okekIaIDcm8qLOgrB6shwbwxC3
         hkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264260; x=1733869060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zx6S/CQb0tqcpFEmYEJYTrZg4ruix/9Kcwctkpw9FSA=;
        b=Xadc2ZhxoHWvvMHZAzdiesZEUfn6meaUrjLYk6yqGXkvubyPBMncJ4Rh/YIEEiDnKQ
         VAzZqpjUm6lDHimgnwKBQLqaYsNNO0rdTn3p5ldY3XNy8WMonwY0//FLNTtoMsdyt1h8
         ZCa+cMgRNdD6NuqNaUnk88Rrtj72cPPA3b4r3cQaJQ8atkfTKWrqFLQyVvmN8OdyPd5B
         kCcS6phpT/yBL+y0zdTM/3Lp46aLgu6sTkx83UHo98/s1SUZ+5qDXzWhFMVSTKxgob6Z
         f9E341pavo9yb41vuxE3rQ8EY7RtG4pXB2yPF8tRF/Pa2G0G6hKI6k2/SwdO8MjT8weu
         baXw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdjIMq7Jt1ngTgbH94mezwndYaj6y+DmecPVKr5sG/iyCz9bOvgIQDr/6CiQ7DV9ZholRhJbvA70YvFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmXzwwjh5D9cx3L71DK6ESGGJiPUGy32z1zwqouwnoPtaYrP/
	NnbCU1lU1cN00zJU/j1SoaZqfvNSLPEc72W38yqc9Ur3G0UuGuAaxrTQTA==
X-Gm-Gg: ASbGncs3oZodrz+XUHmh1u8AvQNI+qZ2H1c6TX1fnSaYi3fAeYvEnYtmMmvVMkl3Kv+
	FyLCe5yviEBF0BZzQbyewZeb7fsLw/b6Mw0E0IvlenJEot4uqDvf11BuPygzdPpVRUXHx/ARAt+
	bGnWwVKbEK+JfG0MBXvfNIxTIlluzocZs6yj2hGzSuZzHOGisnQMolWazPsY9GI86uWjuzcBzee
	/Rx82TeXcJbY02HmOWznzOun0Flz/pbrBs3Z41WI5FKTI4dRYN1cjRbCXvrVsn8SWKpwBMvdt5b
	Z+0eX+Tm3DNcAvxOhjrjJzDee7NvMhpiVbIaNHvdbhjP
X-Google-Smtp-Source: AGHT+IGeCAxgKWes426gFVAzXXMZbzwEVVnZXx8PQ542h2Kmit/6Mex1h0PEefAqKA9aQrmXmE/oAQ==
X-Received: by 2002:a05:620a:4486:b0:7b1:11f4:d0af with SMTP id af79cd13be357-7b6a5d7bb10mr384571885a.29.1733264259850;
        Tue, 03 Dec 2024 14:17:39 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aac1asm552035185a.85.2024.12.03.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:17:39 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: linux-hexagon@vger.kernel.org
Cc: bcain@quicinc.com,
	linux-kernel@vger.kernel.org,
	dhowells@redhat.com,
	edumazet@google.com,
	Willem de Bruijn <willemb@google.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] hexagon: fix using plain integer as NULL pointer warning in cmpxchg
Date: Tue,  3 Dec 2024 17:17:34 -0500
Message-ID: <20241203221736.282020-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Sparse reports

    net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as NULL pointer

Due to this code calling cmpxchg on a non-integer type
struct inet_diag_handler *

    return !cmpxchg((const struct inet_diag_handler**)&inet_diag_table[type],
                    NULL, h) ? 0 : -EEXIST;

While hexagon's cmpxchg assigns an integer value to a variable of this
type.

    __typeof__(*(ptr)) __oldval = 0;

Update this assignment to cast 0 to the correct type.

The original issue is easily reproduced at head with the below block,
and is absent after this change.

    make LLVM=1 ARCH=hexagon defconfig
    make C=1 LLVM=1 ARCH=hexagon net/ipv4/inet_diag.o

Fixes: 99a70aa051d2 ("Hexagon: Add processor and system headers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp@intel.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 arch/hexagon/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..9c58fb81f7fd 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
-	__typeof__(*(ptr)) __oldval = 0;			\
+	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
-- 
2.47.0.338.g60cca15819-goog

