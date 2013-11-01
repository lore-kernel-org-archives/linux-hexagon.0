From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH] hexagon: kernel: kgdb: include related header for pass compiling.
Date: Fri, 1 Nov 2013 12:16:00 -0500
Message-ID: <CAHrUA342CVjhn92pJw16UQX6ReKCpHAXraYXxzCX1DB3Mkcuug@mail.gmail.com>
References: <52739669.9000509@asianux.com>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=auCs7tZ6T6PJ0R67Ev45tDcov4rqY2M2ypx/fVP99Zs=;
        b=wRPo3ZHWTfm9H/9WoV8TF6aKPoSYyow0dOtl43cO2WmyyZrrQzbYuX3Yu1VirkShLJ
         PfJNZNZOi8qDYltdnmhgce0jbuRyv0/rWX7jKxgTHTlSHTfNaYDQlxHopO7qv+cWNzd5
         CgQWywI6Jio/ABHPVa8Yn6UCY0iZVvF5/SA9dzNVsZSFWp9bSWuu1cBlBne0dwpH6uSQ
         2mqraQ3nATvFlZTg3gSL00HnWHe4Nypq5dvgjaFiLcW609YRQaKfj7nX0lz3dz3LRa29
         Drz4t3OE8mbBnJYB+2j/NFv9gPAEHYkUyENqsCzpDMsr/i+O48CBgyUYK8rxJCuR217X
         QJkg==
In-Reply-To: <52739669.9000509@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On 1 November 2013 06:54, Chen Gang <gang.chen@asianux.com> wrote:
> Need include related headers for pass compiling, the related error
> (with allmodconfig for v4):
>
>     CC      arch/hexagon/kernel/kgdb.o
>   arch/hexagon/kernel/kgdb.c:30: error: invalid use of undefined type 'struct pt_regs'

looks good to me

Acked-by: Linas Vepstas <linasvepstas@gmail.com>
