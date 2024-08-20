Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7228FA
	for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189490; cv=none; b=uJflaLAnqri5sp2uXQcCMh8V195XVi1tLbpd0SUNP8sEjrqNkLWjwAgKLULv2ufV4pebmC2Y3od9orzxTqMN06v8Cmi8VU2RCoXAu5U2G7EykJiacLJcWMe24pNRwGVlhlwfBtSTgs44O+NwYSbpZhc4LlU3lRmffjgzbNmShS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189490; c=relaxed/simple;
	bh=zPen0ZDsMIGVeT7oJMVDG1CPWwqKsFrBf0fJYTWFLXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NojQizM70ZqWNfZkwYjn+CKGvob7Xgny/3WOmojNrebGKClZiev+jC5ow1rKIdsv5QsOUPkqMP/D2l0T7P1Fnj24lv1+HNAQJb+64j0SXJmVSMu1vHbB80Mwh5brbt29O8iT/G8uuZk7PpvgV9lAPi+tHjoYj+72d9Ky9yyWO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QgtRJi2j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QgtRJi2j"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso68523821fa.3
        for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724189486; x=1724794286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=QgtRJi2jSiQCN/XtpAjhh9ZnN+IZ0yBFT3MOurUDemJNn50dQ9/zztycEeL+V8hEyW
         JnTYfnUSQmC2qC2s9EKzs4ZcxADs7viKG43/xZHAJzPfyOX/wu7sPwfjbzpo/LMknk4y
         QwTTEDxGw42YPxWWVDXFLkeZruRLj3vapocMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189486; x=1724794286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=Ui+AETIB+q8eg06cvoWmdOEoT0ag9yL+9yjGXU9zAlahx4mbZLvnzox9HKqwTvO4bZ
         5s4e39LnHNZoXJ+Z2LTYkcoLsvPl0LVoUR7WbP1WNgP23POUvGNAZ33Iqt/iLAiQ3IBx
         YlGkH/KmF4pUORdKWO72XmJghZVDdVDZ7wTqJoEHCbjvIpRc5xzs5iWUnEc2VdqOPeY1
         idyrJA5DnMm6fFLnmRJrkbz/jZOJ16e3pXXA2b/e4xANmxozzeC6GN1HUsj8JKnd5JdT
         JEk1kbuv9EflzsbrHp5hKqxxy8T3XrNSsDkeiwiWVySLF+jePaWSiqGL/IDFWZzydym1
         mLpg==
X-Forwarded-Encrypted: i=1; AJvYcCWdi3khw3vg/YNsJJg7aYNVB67bJ4kwSdPrQY/U/kDNeZx1OlPRJtI/yIArgAW5TcoMZEIQNNkag57vup8C@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+k7Nxc7z5APvCaHo6ykaME8m/y4fuwjPuIRArEXDiLitpMeE
	9RBBk/uFifx0kw11CdgGIPGiTOezTReWvN9zF/G5pA0ud/MOadRbIk3kxJRc8JfGTk7w6L128CA
	jhFf7vw==
X-Google-Smtp-Source: AGHT+IFuHDlOBbLuxu4Ij7VlDbvo1OYnb9tf3hbRS3uunt41ywpzmKLvYKs6YvS/Z+seOWXasb/STA==
X-Received: by 2002:a2e:9417:0:b0:2ef:2f9e:dd1b with SMTP id 38308e7fff4ca-2f3f881d463mr1405031fa.14.1724189485875;
        Tue, 20 Aug 2024 14:31:25 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe12eccsm7564428a12.58.2024.08.20.14.31.23
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:31:24 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so4549367a12.3
        for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 14:31:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjGJen9dCem9brkfn8EBkOq1corc5rcIdnvvau/sUP1DYsjQLVY2y0jSJ5LqI6b5CNfuyxj3SuqJ50aihD@vger.kernel.org
X-Received: by 2002:a05:6402:354d:b0:5bf:b29:6eb4 with SMTP id
 4fb4d7f45d1cf-5bf1f164130mr60685a12.21.1724189483542; Tue, 20 Aug 2024
 14:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse> <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
In-Reply-To: <dff57198-7955-ec09-8909-671982834673@landley.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:31:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>
> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
> somewhere to at least smoketest...)

The '&&' is just a typo. It should obviously be just a single '&'. As
mentioned, the only testing that patch got was a x86-64 UML build
test.

Fixed locally.

               Linus
