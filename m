Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A99461
	for <linux-hexagon@vger.kernel.org>; Wed, 17 Jul 2024 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192297; cv=none; b=fbmYPWtsymragcLNtRR3nm1wDemkQ/2ML2Wrz7EVzYmWvexkZjAh3CwM2UIaP3mqkIPgqV2i93y1dInmjb7W7rVOmjabNHoNl8prTWbZ9D86zzYY/cJwg4DxYNMPVQREC6DaF2Lcz5EHhjqoibwOv+XqVvmauxnL1D5UVym0iKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192297; c=relaxed/simple;
	bh=vABRMnRmbUscNHZGwHRUTWrzrPZYmjEVucxlkyKGsgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azbf0rdu5DEOAZpUSnhsdb4skk806a8G1eTnoVERPXBU5KJGaj7z3Uz7vqP4xB5o41LdXdq6Scl9rNRSh8cqteHpVHazTzVEV84kIfyrRcPBwyOZOzT9BH8QYbUYjBAIKUaBKP2yytT04Uf/Pp3Fvc6wIyzWfKORzgW+9YqClJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f8yPgeit; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f8yPgeit"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso766762266b.1
        for <linux-hexagon@vger.kernel.org>; Tue, 16 Jul 2024 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192293; x=1721797093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=f8yPgeit0trPzf158mBqmJrixK99hTAkVQWEJBF7IGRUhObT2moHckMFsWDXHW06qi
         pDj0PhhQGv/QgPVG86oQOs3G7msAs52ca66pnqSDSFcieSy0841w3J/H4vO4t9ZH6Upr
         /iwTO1Z07JhObsbU1W2dhBgmKuuWHrb6Et6q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192293; x=1721797093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=m8/mfcMPKUR9yjxByo6Obv9GFMaS1LclG8rByWWCesYXvqVkhND8mFFnHZFCqM94Jg
         1/VY3sumFLyYP5GXzmBFGYTBxAO5gZw1cE+QmY+WpSI3OZLPBl6Mr6g9wUA0DPVmyk2N
         7m+JvgA5IwQjs+42ILH+sRbpfuXD31+S3HO3n2gKfUqM5DF4fVdOBOaGxuzduDglH9dA
         R8hWjfe0QlHrTvVcFRzbcltjx3fBVFtsHTlPwH6Jtx1Bmg4qiv1E93kAXh+Og9fKupRC
         TT+1OE5h4XXVKcfQBaEodidjf0k6jLxCeoQpX6xwfd6RO88rtbTvWe7DXjf7XAThZFo+
         O5RA==
X-Forwarded-Encrypted: i=1; AJvYcCVuoILw4rrxgHUxBtT7rarWb4+ac6F/Sbx8SgkFKsuV//xnq2bfsmRDrOX7U8fEMwoHGqj+OR4V0YzNNUIWKiQ1TsYl+OiHh1r6ieYexQ==
X-Gm-Message-State: AOJu0YyqjjtvaG6yiHqjwLhZ/JdkbauOW6NHj+dJykUCvblazn76Qrdw
	vguZ678a9Wm9u7L2JEfVtgx2LmlzEhPOXanpgNjMaAqOdRZJfu/tB4WkueowbpUBaWi/wYGldFi
	SDWqDuw==
X-Google-Smtp-Source: AGHT+IGSmUq+8NRSYOdb5VFt4PvW/QMKNhiZapjlsxPbLpke0HUN6koZe+YGKY7UjPQHLeg29L/RWQ==
X-Received: by 2002:a17:906:1348:b0:a77:cd6c:74e6 with SMTP id a640c23a62f3a-a7a0133778emr30621466b.55.1721192293612;
        Tue, 16 Jul 2024 21:58:13 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820d21sm393336666b.198.2024.07.16.21.58.12
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1559887a12.3
        for <linux-hexagon@vger.kernel.org>; Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCf+yy6tHD+klPA4OGsJ5LCAUBxUg/d8/gqysv0xqKHQ3VOT3Sfxf9q583aNLnHURKLUEFOE1CAyDzw1G+sOjYzZ5shvoSvKhT6kxHOg==
X-Received: by 2002:a05:6402:5244:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-5a05b7ee599mr504374a12.13.1721192292251; Tue, 16 Jul 2024
 21:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com> <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't see those either (this is an x86 defconfig example):

Note, it really might be just 'allmodconfig'. We've had things that
depend on config entries in the past, eg the whole
CONFIG_HEADERS_INSTALL etc could affect things.

And yes, I build everything in the source tree, so $(obj) is $(src). I
find the whole "separate object tree" model incomprehensible, and
think it's a result of people using CVS or something like that where
having multiple source trees is hard.

              Linus
