Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD128FA
	for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167936; cv=none; b=BJXIVniyKrooOsnDR34sD0sLGsoW+TdrPYc01x9M/MQcuJsUUftsQQwaK5eY7I+NAgGUClt+LJ2fmSOtNmx9ohnBZlZfxlTEQg6YPfF3W6eTlnpljJA02RfVxvmoVezK/50GqS4Ca7Q3k0O2/xoNcD3q5VNTqb/Ev2n3B9A24kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167936; c=relaxed/simple;
	bh=MiDlbS6ff17tWH6m3MZ6F9tz3FBlacdmGvTetKNSYdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ljo2m8Rlf3OkA8Gm9div/vhtLhwSZ+Ljo6rApDp+B4pUNbbGu2yr85VsOJXPYLOlF8nNMAGM35LS+kuansqqUjwnlI+0pRtkA59T/UY6ljK4UpBmIVaq/vxKOpG+8HaipOGTf6VihfdkcXB7qVgAX7aiFGDqFfe6jFDiWeY1sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UHYOOkxN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UHYOOkxN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so591159066b.3
        for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724167932; x=1724772732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=UHYOOkxNVXM29kamtryO07bOv8PDGfz6NrY3GUn0HaOsR79Wdv/4EdikNHzwzqmuuf
         2WyVDsWNsLf5e5enYY45o6eRvNlHTjCRnmTo9bSmQQRfznhtX+GTjjjw3CbXiIosGWew
         OmJEgsHyLVBzXKWa+G2/qnm/66SLAMFvq+d1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167932; x=1724772732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=Myz16aFRP1v2qsTCBQOqyzHletu4EPyxu8Omz9iwtm6CZiXDAKmbjGUke7j6FDDOio
         YQuLUkU1gBeRIeVSZrh6kiwwbD+ym/UWCGDF2qsUWxzZd7EFOeH+hxKBj3dsnX3rAZg/
         TFS4QabzXdDndkBBEmK3PCaYASF5BEMq1Z7076QyGFpRpTaruSzDwyzUZoWPwgR9HdZl
         opybS9gALgyAjTrIGOX/jeGadh82lFoyN2BjVmn8hQ71f0ZJjAF22KyK6nXMt38ykw/m
         ZNU+D9mxFX1VJWsnrvFwZLBc/W0A6cFcLKUieJri/kpK+rI8G0CIC9PGkXRuRtSVyGNr
         kGng==
X-Forwarded-Encrypted: i=1; AJvYcCX+p3XJ1mQjbDhFpiQaG+zm+v0PElfPKGfxWqAqkHyuk54Z6tD8j0Fc/5la5G0dePfsLXosPshYcAmDennN9mkQsxLmhnN7MpRmWJ4WOA==
X-Gm-Message-State: AOJu0YxyToGkpzkPaimkMumLD3R+l9prYex/BpgdBNReJ7EiKLPusDLa
	b2OibdP6xSiOsJ4GK3RDI5izD4vc7qEf7fy88wqBciQWGxAiv3OVOF/HmfTWd2lMy0KKQ138ubj
	DgQ6o+w==
X-Google-Smtp-Source: AGHT+IHnygDIezeWzVljmdSF16dNAxL8TtCedyiCNczu5sxU813Fw4GpQqyFyw2IdDKdmFbxyS4Czg==
X-Received: by 2002:a17:907:d58f:b0:a7a:9f78:fee with SMTP id a640c23a62f3a-a839292fe5emr1050550266b.17.1724167932163;
        Tue, 20 Aug 2024 08:32:12 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396cfa5sm769787766b.207.2024.08.20.08.32.11
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:32:12 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so2335959a12.1
        for <linux-hexagon@vger.kernel.org>; Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJedu1mBFi3vOe2H+EjBALELMwry3FUOY2rfPOBkDZPQHqU8yngFT/y+q0iBtVl8OVTmJstEvLWcyKB4Us64D0FqtzS3zrHCSjx4+09g==
X-Received: by 2002:a05:6402:2710:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-5beca5c5750mr8152922a12.19.1724167931490; Tue, 20 Aug 2024
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <87y14rso9o.fsf@mail.lhotse>
In-Reply-To: <87y14rso9o.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 08:31:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > +static struct vm_special_mapping vdso_mapping = {
> > +     .name = "[vdso]",
> > +     .pages = syscall_pages;
>                               ^
>                               should be ,

Ack. Changed here locally. But I assume you also don't actually test sh...

It would be good to get acks from the architectures that still used
the legacy interface.

              Linus
