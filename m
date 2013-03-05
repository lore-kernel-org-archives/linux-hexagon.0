From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: Serious error in the code
Date: Tue, 5 Mar 2013 14:09:25 -0600
Message-ID: <CAHrUA34vZr7Z8DwQMyvOQ4E1X1x8sEqX_Z9tu0vXnhW79An+kw@mail.gmail.com>
References: <e4970b507ec53673b77261c392ebbbff.squirrel@www.codeaurora.org>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KViGqpYO5mObgzPNWG+TpHxGDHIA+EMxVnFDsOVzuf8=;
        b=cwLskDv8VrMBvTzL/4HKbR3SPM5zD0IlkVL7JjqKKT5SmqHlMMOYxm/mywBWDw+wM+
         Mg0477AbvLblZx0bXrX7L8UbdLCQbqd77VbXypptrJiyLp9BcCjn/q1GfRF8jbUBaoJH
         iCKtZUVMui/ayF1ra0rVNZ847y8FDBaXqeM91niyQp4Cp9jhsHKJg5amZZ5jeMd3PZLM
         eqdiScSqItVCp1UlkrN4t+Toa0RdwK7XDZc91FkUVMURh06xXn/wxAZDbfPGuBes3P2L
         t6OEubwOv0z5qgReNW1Zf8gD+fLdP2NSe9rrhHF2TduA6qBBGKoZrpHx06bfJk/BjZxh
         JTiQ==
In-Reply-To: <e4970b507ec53673b77261c392ebbbff.squirrel@www.codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rkuo@codeaurora.org
Cc: cotulla@yandex.ru, linux-hexagon@vger.kernel.org

On 5 March 2013 13:19,  <rkuo@codeaurora.org> wrote:
> On Sat, Mar 2, 2013 at 7:59 AM, <cotulla@yandex.ru> wrote:
>> Hello,
>
> If you find other stuff or have questions, feel free to post about it.  It
> sounds like you've made pretty good progress.

Well, the meta-issue is that he has code that runs on bare-metal
hexagon, without the hypervisor, and the question becomes "should
this code be accepted and merged?" (I think the answer is yes) and
"how?" (I'm thinking this would be with ifdef's and CONFIG_HVM)
and finally, "when?" (he claims not to be ready yet, with cleanup required.
but I'm very much in the "push early and push often" camp).

-- Linas
