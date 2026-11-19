Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066378;
	b=ht7LdEwv6e88FPEEtRsbNzIU5TV6OFOpKsMcfl78UKE9tywR/hKc5JLG4y1H4X/+FeyU
	 VPQupbCH8j//7rp97g8FQ63kx5kODbJarAE8j7hldhSa+wIbk4Tanl5O1+moJ2mJToNgi
	 ndYbKtVod2GNyUZVpjaoNnKG/lepjUKi5wIKNxkdgs7cnBLoxnnKHvqTy7a82Au00VOIW
	 ublY0xMZVm+/mW4rCKgL+SZlCcCIf8wZLSgxEJMurdzcvVIWn7ZQFaeFw1L3pUp4xC1e/
	 9OfkBzlXGvdngguaxmQvU5MNLRxY0eQ6EHrijLPBkCZzIJ3GpX8fx1mJ20ebuXqeH/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
	b=dQJt41E8idmUpgP0PzGleTaaFGKSAdue7opEeDgvDhXMJuH/9THejsG+Tgi7pNDsvGrO
	 8HPcXgI8tHUOO8uWW1NDxySyX064A2J+eksQf3JVevmLfWbVqZv8kIOdiNx/l+pGSXvUj
	 /U4BTcS/cgbC+IKaGFOp115SwvUrS72XKTReG+F7Sa1qn72w/DLb7VPxJWg2eC4MhYHvl
	 bJUXAc+l81aG7nN8dz0pgMdLHMsAdHazHWGmNQ2/JTYWHSphvKOhZnEGC5H783iKAjnHY
	 qLHWknrgUMJ7Zt7tNXsT+lDzCo8RtJ/SFQunQCSO9I4DFe+QbGr+tH9yQpGTapcmtgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4bHvQfM;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1D606A325
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 05:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB1D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4bHvQfM
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1416784a91.1
        for <linux-hexagon@vger.kernel.org>; Wed, 18 Nov 2026 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795066378; x=1795671178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
        b=m4bHvQfMo1pkxMoHcCCQNr9n7SfiTmpc1LKr7p9qJ4PxkkegxRvXssI19ZGfs/LFAV
         6kk7mSHQfCoAfQRNqOwJcXLuSondiZK9weZ+hi/CK2xPoJB3MtYTAo+2ZKze7eJfvoxa
         gpP1jqivfqclIsEO9pG/s9O/AqSNReHJHtacW/79zulct+/9VOGREHxJ8da2foaOaR4j
         tr3XAXJIVGEj5cDtPosGO8jyNuDsq/Hm5y9mLYH68UfwD/l9mVquywByiXrcbvSJ20c5
         UTVr99bCNOSVUQww0oc3T9o9uZWSge1hpp3DyldseonyBO1PyMHkT0mXXIukGbwt2d7C
         cnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066378; x=1795671178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
        b=gUeTwuuNzfPVdKOrP1lLpLEVGI/Qljlr4PlIbRMCjus3j3Dz0pM7p+d9Z0pLnJhwcw
         upmBVAQftz+MBSOpQxEIP25Fw6Y+HvezhG8ZqdRo2sBTEt+oeB4RBuoW3UwnufrI0ocV
         K9M+4rNV+z4htDWbEsh/XoBQfw21kdEzozL8RilDP8vLakIBYh3Bd4sy7ZYJle1tf9Hy
         PZWA8k6Eh6YtUyJ0hhLY/VjyAw/QZWG8rkqIVUe2c2Gq+sQ1Q06qstGyzNcN9Ho966fC
         pMS2m5Id5HinsiY763t4rlqqlBOQTKrmsbJ/PHetaR2t7Eo5msLY7f4Krl7SfRmBtyp4
         4n8w==
X-Gm-Message-State: APuU4Z9PF56IqmABQGkxWHeAeV9WtRfYjAkU8Da1Dl6OaTec/ru3uDsr
	8/exUbwSVIMybU6oklMTizJmrYpQQ0yXwsjhLJhH3yVrI2Ng8U582Amh
X-Gm-Gg: AZFdTZcHN+sTgLSfzUZnO3syO97dZ0LXnIVCKqnMP51gkkp0uCPlxldXW/nJY5FG35g
	YUDNrb1VoWLw5oVBgqliIUiz62dBBwYM17duMqEgnV6qwvR5Wq/b7/btPI3iNQF37SZkYI2wQbB
	2znXv/eX94CCkbdqpNx9cRid6UMZJ9Zf8d/mHZ6kC/IvEr7h+QU0HAwlR8HJMKOmx4VZTq9K0c7
	S9TCPyef6sZ/F1KLai6HIojNtCLkb6U5IkdXobbxKItd5TmiMOyGEB+MG3avz6kd7bZ3aaW6H98
	UKEmf++RKpEi225I5TM4tV6xaTmoPCi7IBsoVTyC0v+gdORgsAWQmBPOuNkEdqj311u9dYT5lbf
	l6xEMZxBd7WhTbwM44tsAIDZeAmdG+rwuxJN1KCVCu2DFjb/4mkHPtHp3CWX9kdabwBbyKqQX/b
	ZwbS0i0li7SwZDUSxWKNvGNLC2x4RuCLIHz4nEdGyFFu8K1mUVu8FqL6bMDtLabPJQeUV0a0lDk
	WzicxmjsLr5BdwiP8a+AUqp/kNOZIOuuRAmDHeeL2wbOXE1lSnKjWyBHwijBJ9UKM1/JIgsOaXN
	qJ/A5XZY5SlcQjbIfLdCx3hDmP9YuMphGw==
X-Received: by 2002:a17:90b:28c8:b0:3b3:ca9e:9e22 with SMTP id 98e67ed59e1d1-3b3d075979emr5015646a91.17.1795066377601;
        Wed, 18 Nov 2026 21:32:57 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534aec9bsm1047080a12.22.2026.11.18.21.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:32:57 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>,
	Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(), fls() and ffz()
Date: Thu, 19 Nov 2026 13:32:49 +0800
Message-Id: <20261119053249.2098578-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <av3-Nf01tdGw62lh@yury>
References: <20261117054939.2126980-1-shingekinocore@gmail.com> <av3-Nf01tdGw62lh@yury>
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

On Wed, Nov 18, 2026 at 02:36:21PM -0500, Yury Norov wrote:
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
>
> Would you like me to move it with the other bitops material, or leave
> it to Brian?

Thanks for the review.

Either way is fine with me. If Brian has no objection, please take it
with the other bitops patches.

Brian, would that be OK with you?

Thanks,
Tzu-Ching
