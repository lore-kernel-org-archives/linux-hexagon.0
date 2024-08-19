Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C449627
	for <linux-hexagon@vger.kernel.org>; Mon, 19 Aug 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099059; cv=none; b=ov9aJicPSD3xKBhCSJCWg69NJWk+L399pMqGMAgetMU+xbOsyhafaAf2pEnVAdBsUEyNkM1iNQA3KwdSb9ctl/rsVhCVX9g6f9AJLzCGy4bF2VAStsI1+Tc+ZKGUEktDs/5Yh0ljELDepoLqSkQ/DAaNNhhF8TBOUxGhjt/KarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099059; c=relaxed/simple;
	bh=MP2kPJdQKYK5hGOu9VTob2QU2S+5BQfmeHYP4bjRtok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bri1l+ZpVuH3owe+fmhVRr1Goi5JmrPY3c9esgmQ1V+KescQkp0ZpXkcM9WRlZdqCqJw8dq1njyOCQAm/4aYjx/l0UX26SI7zHAnOE3v+FtxM99B4Sq1b1WwLdNjYWD4u1fVzfohLqzNfhqvq41euM2xtTtjsLsNQ9mGpP1vLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fadlWcdq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fadlWcdq"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a728f74c23dso630339166b.1
        for <linux-hexagon@vger.kernel.org>; Mon, 19 Aug 2024 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724099056; x=1724703856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=fadlWcdqKyU17qnYi+AKBPP59x+o9g0XnALzr54PSgadvroTqcpNNR7VGj12M0jUlC
         bsw60Vvd/QW00cfT9vSSN5A5MIPlNGyRXcehZcfao5d3L8UF0sFTfZd1LOYKPIN9n9pN
         z/GRjGFvDPJ+mO0MEUif6/SqtxQQdqw917cms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099056; x=1724703856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=r9mKwSI8GhCi5xcifw2lH6NheKjYUKSLDpwtOR9nf6Xpm47dLrcznwgy8nN3o217YL
         TQESo+lUDGaEdlaPSAXX5Ot4e/nTPzoXDv0+eWdwWq23XJB0xd5LSiLSUcGK1UG9GRwE
         T9wo0b2Lt3+Q2t06zJZJAHHnUVbgA2pswT4UXBzLQsc/Z5zUQRf8l6RZ3I2EylAGkzXr
         jqpWQRPAw5lm+WT50ArkUgajZf5U69p022vvwJOypz12YZad6HMYFwUJRFni9W+yY5qI
         +026L5hPXTsnFue6E7POfuFuRmp0pr5OiKccvKJoHpK6cAS7kCQuIQjkQqss0+LlKN0E
         Wp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRPD0oeMgTzkurZ1uKsdi+VqAYrI1phjXWOnKDXqSrrfkr6wiWowLKph+DUpOyXB2fS9OY+ixn+ueU2WVm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmq26EYs/SiYvBzGPy4VaxOl5Q7b7CvVM/a7ExvkKmw2Ox6cnu
	qPz+gE28fQUcTHyCMtkpdhDd2skZr9dvuWM4mm9Fa3KiwJxpIW7GwZnTya4hgjjIyaFJwTpXshp
	Q9ThBIw==
X-Google-Smtp-Source: AGHT+IG79nvgLXvVhmLRv9OJm9+3ZPdmQAwFuz7XZpIMMoe7ZqIRReMJUS/MXKSumrF4ePpDpe869Q==
X-Received: by 2002:a17:907:efea:b0:a7a:9144:e242 with SMTP id a640c23a62f3a-a8392930d51mr924473666b.27.1724099055350;
        Mon, 19 Aug 2024 13:24:15 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472f4sm669282166b.184.2024.08.19.13.24.15
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:24:15 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9e25008aso596536666b.0
        for <linux-hexagon@vger.kernel.org>; Mon, 19 Aug 2024 13:24:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU08BVtOUM6mrwYMYyHOoAns4zU7jYMF17IRvaTfIRYdYM2zSKH2tceC/K33WlV9SakU99L9TZDxYu3caS+@vger.kernel.org
X-Received: by 2002:a50:c8cb:0:b0:5a3:a9f8:cf20 with SMTP id
 4fb4d7f45d1cf-5beca8c7c0dmr6123102a12.34.1724098565883; Mon, 19 Aug 2024
 13:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com> <20240819195120.GA1113263@thelio-3990X>
In-Reply-To: <20240819195120.GA1113263@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 13:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 12:51, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yes, that appears to fix it for me. I don't have much to say about the
> rest but others might :)

Ok, I did a quick hack-job to remove that disgusting
install_special_mapping() legacy case.

With this, the old "install_special_mapping()" mess no longer exists,
but I haven't even attempted to compile the result, because I don't
have cross-compile environments for any of the affected architectures.

Except UML. I did at least build it there, but it's not like I tested it.

Adding architecture maintainers and more architecture lists to the
participants. It would be good to actually get this patch tested.
Context for newly added people:

   https://lore.kernel.org/all/CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com/

NOTE! This patch is against my current tree, not the linux-next
changes. But it should entirely remove the case that caused problems
in linux-next.

                      Linus
