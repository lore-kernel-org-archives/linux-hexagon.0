From: Nick Desaulniers <ndesaulniers@google.com>
Subject: ARCH=hexagon unsupported?
Date: Thu, 22 Apr 2021 15:12:05 -0700
Message-ID: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IeGVP/PzjX6GEC4OpuxzmsnoF97NjtiO1q5gl5FI7JM=;
        b=SAN+kJAryw/6OAvi1tysBLGSfweOHsy2ZldSSzEZCPRLWuQEtqq2WNl7iulOF8qc1D
         BRKDUme3/zsS4b7KxFFq5q/l6TDChCgM3mO0HRtlZM4JLJw53bizREK/ojQPzuu0s1yg
         xQCRzYjptXYhJj/GayuEMLBnUMqe43nhh40gtgdshUnp/dtKF8KorrkE59RbC+U0zKF1
         3LoKWqp69J4NsQ19gthobT+D6HMObQNV8sxa+IBu3/Xv5nG1npwJXOXIdqwW4EWw59oi
         K1YbwvUvaBJ4hh2oUUhIm85tfab8MgIoOLpmv6wde2YF9/ioL008RNGVv6XBiYQcTZCk
         LXxQ==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-hexagon@vger.kernel.org, clang-built-linux <clang-built-linux@googlegroups.com>, Brian Cain <bcain@codeaurora.org>, linux-arch <linux-arch@vger.kernel.org>

Arnd,
No one can build ARCH=hexagon and
https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
2 years.

Trying to build
$ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1 LLVM_IAS=1 -j71

shows numerous issues, the latest of which
commit 8320514c91bea ("hexagon: switch to ->regset_get()")
has a very obvious typo which misspells the `struct` keyword and has
been in the tree for almost 1 year.

Why is arch/hexagon/ in the tree if no one can build it?
-- 
Thanks,
~Nick Desaulniers
