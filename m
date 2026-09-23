Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DD48C8AE
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201397; cv=none; b=iEotP07vD97o6cXVs9yt6+K+FWUboRcqbtxVD9d8v2hMB84swxuN1zacwWJOWgeA1kPkPVUeRWedT58jOCJuasiSBu35nySy6302qzNqa4I1AT4BfVdVDbETbT5pZ70qo8vUHT05xMRUbPVmMNMmB6gf9wk00me9OhY1I2ttbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201397; c=relaxed/simple;
	bh=EtOIa+oAShthuIiT1TwrJdQuJPXnDiaoPiPmXnJJfG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdDM11r/LhsBTs/ZIZPM7x/wGZawrggzvvU+VTBT+kqliR+Y6AWG2qnPHLaRkW1HSWkD1539VvvE5Jyj1dPhjo+3BdRuOQO5toE/2+MLIbOhrhzoicpTpC2NANSDM1tPXF3ytNUc/SbkQjTSABdHSRQLtFq1xGAc2RyQcEdHiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JabHTBNb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JabHTBNb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so8400085e9.1
        for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201393; x=1790806193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5dTpfk72zH6uImNLJc12NQcXIxnabFbxH2ktwvSTbg=;
        b=JabHTBNb7ls2uP8xSKvzKXLBupNHM/NFoQnf3Z4Vgscxq88QF8Z8D0p+YbF2B1wwV7
         lCwYSxeuVkvo+PeBdnTSVLKpJKviVNTxtSx+1T78rVQ0BFLmV2LjVeGh1qX8CrOL1epp
         h2rVggzDp/Wl4xPa+nT2S7yHnRu7OT1GebGn7qJR+I0/Zwu7TlE46AOyeleem/qhP5nK
         IUoe7wfrk2Ld1GfUGpeT+r6hIbhEB9TlYbP23ncRr6Ep+/8mXquQv1YopI1kztvbJC7f
         HLTz0LVwkNTMfOPCuROJ2o0vCImMUFEcaOMWNWftvfagKZbNs1frgsZ32UhkYSjfQxyH
         FxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201393; x=1790806193;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5dTpfk72zH6uImNLJc12NQcXIxnabFbxH2ktwvSTbg=;
        b=aEwyQXSkFmzqQ+79LhPnBdcs1ztKkb4UhnEAfnR9WWGD6vAel3UKQ8q8HipQwsyuqj
         AzSobqLQdTWhKuKeCE9EG6FK1FLYXzKpeYGPeT5JPN89hpC6acwBxY2+BDzJ2AizIxO4
         N9XT7rBvPYpTWwmOrC74Eai75l0vXqUBRX14HEO1bt1BM7u7+aUfu5Igd5x9Kjz+Y3L4
         fgNaZKF/yCkarGl8SDbxASxrB+2hm1eoAbI61jtRIpwMpTl9Uisswhul30ocCwDv6lEm
         VIkISbih9RLYp/4FFuGGxdwxTT3tC7ol18NJk+c40r5iTwL2ich1ONuaqgoKzLx0Kb19
         S0rw==
X-Forwarded-Encrypted: i=1; AKwUvBzgkfBBPT7ipoSXfbfTS7CNc6sr+FTro8jathvwpzJEeN2X41Bt9c4ccpNiRH3Nz2sakKTH17JoQZMhQ+PQ@vger.kernel.org
X-Gm-Message-State: AFuF++m6i/ju/ch1R9hTisJuvfl+2UsF8DuspSdDyyTFhSLRtpuJai92
	j5J4ZaL4VeGOcl6yUmjFw1Rw4QDFHjNJWgd9as/mBXrDH/RlOGadoOD4K/jws/rg
X-Gm-Gg: AYBFou0PjeuPOnhgwi2y9d0TlLcDHLyj8HqEV907O0L3W3zvtYT0u8xFBW779TUecsf
	CFEB+KXlWjtHOSw012g8CZXQ4Hhx4ncCDxzBkcFLGFPHvKIP22D/2ScDfkCztPr/PRvzCESv+PE
	O5cYI99latehGDgQxPDhV7ADaCmcpPAjqnLxMW2uXZ0pr5tDL8kGbrTHnyB0e1NP9Dl2r81jZWx
	YEWZhgcfTTWiWcRKK1Qcj5KCNAAJdZJxPeq++xyBUEybVh+fhpICLnf+cvRErYpu5WD8ndjDLOq
	uc2rYgwFp6JRk4roiKlmBetuDKsdXntCq3m1mhKCg3S55zjJJ/poI0CH6l4mDkBY2axvRGlWvIu
	xc1ugsLS0GE6tpDzKxHC+wX65Un2ErNoBImBvDN9s/uxAAL7M9o/f4r2vTlJ+qgHrcxViNdEiEQ
	cGiY+6N9MivJNWI9jfSKkY6MbAIHTe8fPtWU0vZx9ez4OPlbza+UfDWw0s7vE5i9TKHCs55as31
	yEwJUWHs4SC3FSpsdUTmsES1CBwhkgeBiw=
X-Received: by 2002:a05:600c:3514:b0:49c:fc6c:be09 with SMTP id 5b1f17b1804b1-49fe67078afmr8562615e9.32.1790201392960;
        Wed, 23 Sep 2026 15:09:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd42f2sm17189365e9.15.2026.09.23.15.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:09:52 -0700 (PDT)
Date: Wed, 23 Sep 2026 23:09:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, pierrick.bouvier@oss.qualcomm.com,
 paulmck@kernel.org, sid.manning@oss.qualcomm.com, peterz@infradead.org,
 linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2] smp: align struct __call_single_node to 8 bytes
Message-ID: <20260923230951.29231158@pumpkin>
In-Reply-To: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>
References: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2026 08:43:07 -0700
Brian Cain <brian.cain@oss.qualcomm.com> wrote:

> Consumers walking call_single_queue cast each node to call_single_data_t
> and, given that type's declared over-alignment, the compiler may load
> llist.next and u_flags as one naturally aligned double word.  Fields using
> this type, such as task_struct::wake_entry only guarantee pointer alignme=
nt,
> which faults on strict-alignment 32-bit architectures like hexagon.

I think the same could happen on arm64.
The compiler is being told the alignment is 4*sizeof(long)), but I doubt it
can ever matter that it is more than 2*sizeof(long).

The other option is to only ever use call_single_data_t to get an aligned
version of the structure and use the struct everywhere else.
The compiler won't be able to use the 'load two register' instruction, but
I doubt that will be measurable.

David

>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: linux-hexagon@vger.kernel.org
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/linux/smp_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
> index 2e8461af8df6..5773e1fb2660 100644
> --- a/include/linux/smp_types.h
> +++ b/include/linux/smp_types.h
> @@ -64,6 +64,6 @@ struct __call_single_node {
>  #ifdef CONFIG_64BIT
>  	u16 src, dst;
>  #endif
> -};
> +} __aligned(8);
> =20
>  #endif /* __LINUX_SMP_TYPES_H */

