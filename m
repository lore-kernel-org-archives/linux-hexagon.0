From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Please pull the Hexagon branch
Date: Fri, 19 Oct 2012 11:08:40 -0700
Message-ID: <CA+55aFwqB7KcPTLuiirTS9rSz1YiUfxJQ6BNbLR2SupfBt5UWg@mail.gmail.com>
References: <20121019001619.GA24832@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=wp9bEuJzO8Le2BZQJ2X9rntWRoQcD+VQHwuEe1BZ3PM=;
        b=zP7mnc1VrL5nk+xXmprtJ8R8yxKAamTqCsJ3saha7U29g5SI+vOXVKIZQM/KbA7Ss1
         cSoW/ruGrODoLp9trhYwXMPaY+Od9uzc1yLi4Kt524/gJj7WAgQR78c24tB1+3O7R53C
         gbTmuMrvuBnpgg8Q2VBUtzg32LhOucMcFt6pJWroSr2NPcUDkux0sUHqtox/LIDhQBwp
         oGi+JF7yX0sM3brD3fz/F2lBNK5GGW9NVAaq3fkhsjczVqBNi3UBrVsuvEB9yY/pU1VM
         6SSkeHk19QtN3O/aqm+sbag68FrxP6549OJzKQJvwOtXJOycVbZeiUVa6YeoNO9eFLsh
         +feg==
In-Reply-To: <20121019001619.GA24832@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Thu, Oct 18, 2012 at 5:16 PM, Richard Kuo <rkuo@codeaurora.org> wrote:
>
> Please pull the following small changes for the Hexagon arch.  It includes
> the Hexagon UAPI changes from David Howells and some CR marking changes for
> the transition from Code Aurora to Linux Foundation.

Can you please also check Al Viro's email titled "new
execve/kernel_thread design". He has hexagon changes he'd like tested,
and you were cc'd on the emails. There's a "arch-hexagon" branch in
his tree that needs testing and then fixing-or-acking.

             Linus
